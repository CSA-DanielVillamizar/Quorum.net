[Quorum.net](http://quorum.javiercanon.com) &mdash; An open-source, Live Updating, Web Quorum Voting Platform.
==========

The minimum number of members of an assembly or society that must be present at any of its meetings to make the proceedings of that meeting valid. There were just about enough people present to form a quorum.

[Quorum.net](http://quorum.javiercanon.com) is an open-source, self-hostable, **live-updating** voting/polling platform, for both live meetings, or extended polls. 

Polls can be dynamic, meaning users can(*if allowed*) contribute options and questions themselves.


## Current Features:

- [X] Register to assembly.
- [X] Live Quorum Dashboard.
- [X] Live Questions Dashboard.
- [X] Polls can have multiple questions.
- [X] Web Responsive Mobile client for voting, share the URL.
- [X] Questions are anonymous voting.

## Future Features:

- [ ] Users and Roles.
- [ ] Questions can show voter names.
- [ ] Anyone can edit, delete, or create additional questions, and options (if allowed by the creator), at anytime.
- [ ] Public Live chat on the sidebar.
- [ ] Private mobile chat. 
- [ ] Questions can have expiration times.
- [ ] Questions can have thresholds (making sure options with too few votes don't win). 
- [ ] Image and description support for all questions and candidates.
- [ ] Multiple answers for Questions.
- [ ] Android Mobile client for voting.
- [ ] IOS Mobile client for voting.


## Tech used:

- Microsoft Visual Studio 2019
- [Bootstrap v4](https://github.com/twbs/bootstrap)
- Microsoft Asp.net Webforms 4.7.2, C#
- Microsoft SQL Server 2017

## Screenshots

![screenshoot]("docs/screenshoots/Annotation-2020-03-30-200815.png")
![screenshoot]("docs/screenshoots/Annotation 2020-03-30 201129.png")
![screenshoot]("docs/screenshoots/Annotation 2020-03-30 201304.png")
![screenshoot]("docs/screenshoots/Annotation 2020-03-30 201350.png")
![screenshoot]("docs/screenshoots/Annotation 2020-03-30 201544.png")
![screenshoot]("docs/screenshoots/Annotation 2020-03-30 201735.png")


## Philosophy of Javier Cañon
* KISS by design and programming. An acronym for "keep it simple, stupid" or "keep it stupid simple", is a design principle. The KISS principle states that most systems work best if they are kept simple rather than made complicated; therefore, simplicity should be a key goal in design, and unnecessary complexity should be avoided. Variations on the phrase include: "Keep it simple, silly", "keep it short and simple", "keep it simple and straightforward", "keep it small and simple", or "keep it stupid simple".

* Select the best tools for the job, use tools that take less time to finish the job.
* Productivity over complexity and avoid unnecessary complexity for elegant or beauty code.

* Computers are machines, more powerful every year, give them hard work, concentrate on being productive.


## Community ##

* Website, videos, photos, docs, etc. ()

## Issues and Bug Traking ##
Please submit *bug reports* or *feature requests* on GitHub:
* [Issue | Request Features](https://github.com/JavierCanon/quorum.net/issues)


# Getting Started


## Prerequisites

Things that you need to have/install before the software.

* Microsoft Windows 8.1, 10, Windows Server 2012 R2, 2016, 2019.
* .Net Framework 4.7.2.
* Sql Server 2017 (Can use other versions from 2012).
* IIS 10 (Internet Information Server).


## Installation 

*If you want to self-host or help develop.**

* [Download Last Build](https://github.com/JavierCanon/quorum.net/releases/latest)
* [Old Installers](https://github.com/JavierCanon/quorum.net/releases)

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo


### Deployment

Add additional notes about how to deploy this on a live system.


## Contributing

Please read [CONTRIBUTING.md](/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.


### Development Dependencies and Licenses Requirements ##

* Microsoft Windows 8.1, 10, Windows Server 2012 R2, 2016, 2019.
* Microsoft Sql Server 2017 or up.
* Microsoft .Net Framework Target 4.7.2.
* [Devexpress 19.2.6](https://go.devexpress.com/devexpressdownload_universaltrial.aspx).



### Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 


### Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

#### Coding Offical Reference

1. [MSDN General Naming Conventions](http://msdn.microsoft.com/en-us/library/ms229045(v=vs.110).aspx)
2. [DoFactory C# Coding Standards and Naming Conventions](http://www.dofactory.com/reference/csharp-coding-standards) 
3. [MSDN Naming Guidelines](http://msdn.microsoft.com/en-us/library/xzf533w0%28v=vs.71%29.aspx)
4. [MSDN Framework Design Guidelines](http://msdn.microsoft.com/en-us/library/ms229042.aspx)

#### Model 

*In this project, used only when you need make Unit Tests, because of nature of Webforms and Winforms*

[MVP](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter) 

```
First, anything that a user can interact with, or just be shown, is a view. The laws, behavior and characteristics of such a view is described by an interface. That interface can be implemented using a WinForms UI, a console UI, a web UI or even no UI at all (usually when testing a presenter) - the concrete implementation just doesn't matter as long as it obeys the laws of its view interface.

Second, a view is always controlled by a presenter. The laws, behavior and characteristics of such a presenter is also described by an interface. That interface has no interest in the concrete view implementation as long as it obeys the laws of its view interface.

Third, since a presenter controls its view, to minimize dependencies there's really no gain in having the view knowing anything at all about its presenter. There's an agreed contract between the presenter and the view and that's stated by the view interface.

The implications of Third are:

    The presenter doesn't have any methods that the view can call, but the view has events that the presenter can subscribe to.
    The presenter knows its view. I prefer to accomplish this with constructor injection on the concrete presenter.
    The view has no idea what presenter is controlling it; it'll just never be provided any presenter.

```


# Authors

* **Javier Cañon** - *Initial work* - [www.JavierCanon.com](https://www.javiercanon.com)

See also the list of [contributors](/AUTHORS.md) who participated in this project.


# Supported by, thanks to 

![Caphyon](https://raw.githubusercontent.com/JavierCanon/Social-Office-Browser/master/docs/img/advanced-installer-iconNavLogo.png)  

[Caphyon Advanced Installer](https://www.advancedinstaller.com) 
---

![Softcanon](https://github.com/JavierCanon/Social-Office-Webackeitor/raw/master/docs/images/logo_softcanon_200x75.gif) 

[Softcanon](https://www.softcanon.com) 
--- 

* [SQL Pretty Printer for SQL Server](http://www.dpriver.com/products/sqlpp/index.php) 
--- 


## Honorable mentions

* https://realfavicongenerator.net/



# License

This project is licensed under the GNU AFFERO GENERAL PUBLIC LICENSE Version 3 - see the [LICENSE.md](/LICENSE.md) file for details.

---
Made with ❤️ by **[Javier Cañon](https://www.javiercanon.com)**.

