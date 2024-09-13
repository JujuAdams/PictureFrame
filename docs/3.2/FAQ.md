# Frequently Asked Questions

&nbsp;

**What platforms does PictureFrame support?**

Everything apart from HTML5. You might run into edge cases on platforms that I don't regularly test; please [report any bugs](https://github.com/JujuAdams/PictureFrame/issues) if and when you find them.

&nbsp;

**What versions of GameMaker does PictureFrame support?**

PictureFrame supports GameMaker 2024.8, and in theory supports every version of GameMaker later than that. Later versions of GameMaker may change functionality in a way that PictureFrame is not forwards-compatible with, but PictureFrame uses only native GameMaker audio functions so is in the best possible position for long-term compatibility.

&nbsp;

**How is PictureFrame licensed? Can I use it for commercial projects?**

[PictureFrame is released under the MIT license](https://github.com/JujuAdams/PictureFrame/blob/master/LICENSE). This means you can use it for whatever purpose you want, including commercial projects. It'd mean a lot to me if you'd drop my name in the credits (Juju Adams) and/or say thanks, but you're under no obligation to do so.

&nbsp;

**How do I update PictureFrame?**

Releases go out once in while, typically expedited if there is a serious bug. This library uses [semantic versioning](https://semver.org/). In short, if the left-most number in the version is increased then this is a "major version increase". Major version increases introduce breaking changes and you'll almost certainly have to rewrite some code. However, if the middle or right-most number in the version is increased then you probably won't have to rewrite any code. For example, moving from `1.1.0` to `2.0.0` is a major version increase but moving from `1.1.0` to `1.2.0` isn't.

?> Please always read patch notes. Very occasionally a minor breaking change in an obscure feature may be introduced by a minor version increase.

At any rate, the process to update is as follows:

1. **Back up your whole project using source control!**
2. Back up the contents of your configuration script (`__PfConfigMacros`) within your project. Duplicating scripts is sufficient
3. Delete all library scripts from your project. Unless you've moved things around, this means deleting the library folder from the asset browser
4. Import the latest [.yymps](https://github.com/JujuAdams/PictureFrame/releases/)
5. Restore your configuration scripts from the back-up line by line

!> Because configuration macros might be added or removed between versions, it's important to restore your configuration scripts carefully.

&nbsp;

**I think you're missing a useful feature and I'd like you to implement it!**

Great! Please make a [feature request](https://github.com/JujuAdams/PictureFrame/issues). Feature requests make PictureFrame a more fun tool to use and gives me something to think about when I'm bored on public transport.

&nbsp;

**I found a bug, and it both scares and mildly annoys me. What is the best way to get the problem solved?**

Please make a [bug report](https://github.com/JujuAdams/PictureFrame/issues). I check GitHub every day and bug fixes usually go out a couple days after that.

&nbsp;

**Who made PictureFrame?**

PictureFrame is built and maintained by [Juju](https://www.jujuadams.com/) who has been writing and rewriting audio systems for a long time. I've worked on a lot of [commercial GameMaker games](http://www.jujuadams.com/) over the years. PictureFrame is the product of practical experience working as a consultant.

&nbsp;

**Can I send you donations? Are you going to start a Patreon?**

Thank you for wanting to show your appreciation - it really does mean a lot to me personally - but I'm fortunate enough to have a stable income from gamedev. I'm not looking to join Patreon as a creator at this moment in time. If you'd like to support my work then drop a credit in your game and/or give a shout-out on the social media platform of your choice.
