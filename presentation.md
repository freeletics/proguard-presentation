footer: © Edward Dale, 2017
slidenumbers: true
theme: Next, 9

# ProGuard

Edward Dale
@scompt

Freeletics
https://www.freeletics.com

August 31, 2017

---

## Agenda

* Overview
* Steps
* Problems
* Future

---

## Purpose

> ProGuard is the most popular optimizer for Java bytecode. It makes your Java and Android applications up to 90% smaller and up to 20% faster. ProGuard also provides minimal protection against reverse engineering by obfuscating the names of classes, fields and methods.
-- https://www.guardsquare.com/en/proguard

---

## Purpose

> ProGuard is the most popular optimizer for Java bytecode. It makes your Java and Android applications up to 90% **smaller** and up to 20% **faster**. ProGuard also provides minimal protection against reverse engineering by **obfuscating** the names of classes, fields and methods.
-- https://www.guardsquare.com/en/proguard

---

## Highlights [^1]

* ProGuard is a command-line tool with an optional graphical user interface.
* ProGuard is easy to configure. A few intuitive command line options or a simple configuration file is all it takes. All available options are detailed in the user manual.

[^1]: https://www.guardsquare.com/en/proguard

---

## Highlights [^1] *(continued)*

* ProGuard is fast. It processes small Android applications and entire run-time libraries in seconds.
* ProGuard is the default tool in development environments like Oracle’s Wireless Toolkit, NetBeans, EclipseME, Intel’s TXE SDK and Google’s Android SDK.

---

## Highlights (annotated)

![right](YaoMingMeme.jpg)

* ProGuard is **easy to configure**. A few **intuitive** command line options or a **simple** configuration file is all it takes. All available options are detailed in the user manual.
* ProGuard is **fast**. It processes small Android applications and entire run-time libraries in **seconds**.

---

## Steps

![fit,inline](steps.pdf)

---

## Shrink Step

* Enabled by default
* Disabled with `-dontshrink`
* Removes all classes, methods, resources not reachable from from an entry point (seeds)
* Dynamically referenced classes/methods need to be "kept" using `-keep` or `-keepclasseswithmembers`

---

### Example Class Diagram

![inline](classdiagram.pdf)

---

### After Shrinking

* *No seeds*

![inline](noseeds.pdf)

---

### After Shrinking

* `-keep MainActivity`
* `-keep SecondActivity`

![inline](aftershrinking.pdf)

---

### After Shrinking

* `-keep public class * extends android.app.Activity`

![inline](aftershrinking.pdf)

---

### Keep Options

[.autoscale: true]

**-keep**

Specifies classes and class members (fields and methods) to be preserved as entry points to your code. 

^ `-keep`: Keeping activities or class containing main method.

**-keepclassmembers**

Specifies class members to be preserved, if their classes are preserved as well.

^ `-keepclassmembers`: Keep fields and methods of classes implementing `Serializable`

**-keepclasseswithmembers**

Specifies classes and class members to be preserved, on the condition that all of the specified class members are present.

^ `-keepclasseswithmembers`: Keep all classes that contain main methods.

---

## Optimize Step

* Enabled by default
* Disabled with `-dontoptimize`
* Performs lots of different bytecode-level optimizations to the code

---

## Optimize Step

* `-optimizationpasses` declares how many times to optimize/shrink
* Freeletics does 5 passes

---

## Optimize Step

* `-optimizations` can be used to disable specific optimizations
* Freeletics disables optimizations that cause problems on Android
* More information in `$ANDROID_HOME/tools/proguard/proguard-android-optimize.txt`




---

### Example Optimizations [^2]

[.autoscale: true]

* Marks methods as final, whenever possible.
* Removes unused method parameters.
* Propagates the values of method parameters from method invocations to the invoked methods.
* Propagates the values of method return values from methods to their invocations.
* Inlines short methods.
* Inlines methods that are only called once.

[^2]: https://www.guardsquare.com/en/proguard/manual/optimizations

---

## Obfuscate Step

* Enabled by default
* Disabled with `-dontobfuscate`
* Classes and class members receive new short random names, except for the ones listed by the various 
  `-keep` options
* Internal attributes that are useful for debugging are removed

---

### After Obfuscation

![inline](afterobfuscation.pdf)

---

## Preverification Step

* Enabled by default
* Disabled with `-dontpreverify`
* When loading class files, the class loader performs some sophisticated verification of the byte code.
* **Unnecessary on Android**

---

## Problems

---

### Problem 1

#### Class is unintentionally removed/obfuscated

**Symptom:** Runtime crash

```
java.lang.NoClassDefFoundError: Failed resolution of: Lcom/freeletics/LoginActivity;
```

---

### Problem 1

#### Class is unintentionally removed/obfuscated

**Symptom:** Runtime crash

```
java.lang.NoClassDefFoundError: Failed resolution of: Lcom/freeletics/LoginActivity;
```

**Solution:** Ensure class is kept

```
-keep com.freeletics.LoginActivity
```

---

### Problem 2

#### Code references a class not available

**Symptom:**: Build failure

```
Warning: rx.internal.util.unsafe.ConcurrentCircularArrayQueue: can't find referenced class sun.misc.Unsafe
...
Warning: there were 47 unresolved references to classes or interfaces.
```

---

### Problem 2

#### Code references a class not available

**Symptom:**: Build failure

```
Warning: rx.internal.util.unsafe.ConcurrentCircularArrayQueue: can't find referenced class sun.misc.Unsafe
...
Warning: there were 47 unresolved references to classes or interfaces.
```

**Solution:** Don't warn about classes unavailable on Android

```
-dontwarn sun.misc.Unsafe
```

---

### Problem 3

#### Adding a new library breaks build

**Symptom:** Build failure

--- 

### Problem 3

#### Adding a new library breaks build

**Symptom:** Build failure

**Solution:** Google

Should only happen with non-Android-specific libraries. Android-specific Libraries can add a ProGuard configuration that should be used.

--- 

## The Future

> we are also working on R8, which is a Proguard replacement for whole program minification and optimization[^3]
-- James Lau, Product Manager
[^3]: https://android-developers.googleblog.com/2017/08/next-generation-dex-compiler-now-in.html


---

## The Future

[.autoscale: true]

* D8 is a dexer that converts java byte code to dex code.
* R8 is a java program shrinking and minification tool that converts java byte code to optimized dex code.
* R8 is a Proguard replacement for whole-program optimization, shrinking and minification. R8 uses the Proguard keep rule format for specifying the entry points for an application.

---

## Questions?

### Edward Dale
### @scompt

#### Freeletics
#### https://www.freeletics.com

---

### Citations

* http://knowyourmeme.com/memes/yao-ming-face-bitch-please
