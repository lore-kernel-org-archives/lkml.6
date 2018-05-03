Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeECIUf convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:20:35 -0400
Received: from mail1.bemta5.messagelabs.com ([195.245.231.145]:38291 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751115AbeECIU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:20:29 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRWlGSWpSXmKPExsUSt3Opsa73sVd
  RBsv+c1ucatnDbjHtzm5WiysXDzFZTH34hM2iccZ8VotvVzqYLC7vmsNmseH7WkYHDo8Nn5vY
  PFov/WXzmN1wkcVj56y77B6bVnWyeazfcpXF4/MmuQD2KNbMvKT8igTWjHXT9rIUvOKr6Nvwn
  rGB8T53FyMXh5DAEkaJu/OOsXQxcnKwCVhITD7xgA3EFhGIkOi4d5kNpIhZ4AOTxPctX8CKhA
  VSJa6uncwCUZQmMf/1P6gGP4mZixvB4iwCKhIzDjUxg9i8AgESW29PYofYNp9J4tnBaUBFHBy
  cAkYSDx/EgtQwCshKfGlcDVbPLCAucevJfCYQW0JAQGLJnvPMELaoxMvH/1ghbHmJ7d9+s0PY
  9hKv770DGykhoC/R11gMETaUWDXtAAuEbS6x+M9OJojxOhILdn9ig7C1JZYtfA11pqDEyZlPW
  CYwis9CcsUsJC2zkLTMQtKygJFlFaNGcWpRWWqRrqGFXlJRZnpGSW5iZo6uoYGpXm5qcXFiem
  pOYlKxXnJ+7iZGYHwzAMEOxqbtnocYJTmYlER5v598GSXEl5SfUpmRWJwRX1Sak1p8iFGGg0N
  JgvfrkVdRQoJFqempFWmZOcBEA5OW4OBREuG9DJLmLS5IzC3OTIdInWJUlBLnZTsKlBAASWSU
  5sG1wZLbJUZZKWFeRqBDhHgKUotyM0tQ5V8xinMwKgnzdoCM58nMK4Gb/gpoMRPQ4s9fn4MsL
  klESEk1MOb07JE/94pvyYpqGTf77T2L4zdOirLpSHl2e+te2+qZxQk1aX/DXBSzGMxPtBbmf9
  hpOd8sqFSy+lm/pEODOdcjd2Xm7ldOu1I5r/pf/vCqV3PlkZWFHscMott5c8/YmHfcmWQ1tdX
  0y/EJue89kiv+x88UuvT/9aWbUcvM1SaL2j/dznJ/uhJLcUaioRZzUXEiABJZEv5pAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-4.tower-178.messagelabs.com!1525335626!113191922!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Mark Brown <broonie@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>
Subject: RE: [alsa-devel] [PATCH v2] ASoC: da7219: read fmw property to get
 mclk for non-dts systems
Thread-Topic: [alsa-devel] [PATCH v2] ASoC: da7219: read fmw property to get
 mclk for non-dts systems
Thread-Index: AQHT4GUsuHphZND160Sqg+RURjmwB6QZqjfggAGgMwCAAO2sQIAA9XeAgACASeA=
Date: Thu, 3 May 2018 08:20:25 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E9A89@SW-EX-MBX01.diasemi.com>
References: <1525080203-18947-1-git-send-email-akshu.agrawal@amd.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E93BC@SW-EX-MBX01.diasemi.com>
 <20180501205006.GE2714@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337014C1E9782@SW-EX-MBX01.diasemi.com>
 <20180503013919.GN2714@sirena.org.uk>
In-Reply-To: <20180503013919.GN2714@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 03/05/2018 06:33:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 May 2018 02:39, Mark Brown wrote:

> On Wed, May 02, 2018 at 10:13:55AM +0000, Adam Thomson wrote:
> > On 01 May 2018 21:50, Mark Brown wrote:
> 
> > > There's a lot of things that ACPI *should* do but doesn't - it's a bit
> > > of a shambles how ACPI standards get defined and what's there is not
> > > really intended to handle systems like these semi-embedded ones.  One of
> > > the big gaps in ACPI is that it has no handling at all of clocks, that's
> > > supposed to be done transparently by firmware in the ACPI model.  What a
> > > lot of the embedded Intel people have been doing is coopting the DT
> > > bindings wholesale for ACPI systems but that has problems when you get
> > > into areas which should be handled in some way on ACPI systems like
> > > power and unfortunately clocks are kind of power adjacent so might be a
> > > bit sketchy here.
> 
> > Yes I was aware that previously that was the case, although have not followed
> > this for a while. It just feels here that we should aim for something more
> > generic rather than a device specific property/binding, if possible, as that
> > feels messy to me and I'm sure other drivers could take advantage of this as
> > well. I've not looked at the clock code in too much detail though, at least with
> > regards to this area, so not sure how feasible that is.
> 
> > As a suggestion for ACPI would it be possible to re-use the 'clock-names'
> > property and add something in the framework to handle this?
> 
> I completely agree that ACPI should have handling for clocks but it
> really feels like something that should be done as a proper spec rather
> than just ad hoc by Linux like the x86 embedded people often do - it's
> too close to the power management stuff that ACPI definitely does
> handle.

Yep, agreed. Be nice if someone could do that rather than us having workarounds.
