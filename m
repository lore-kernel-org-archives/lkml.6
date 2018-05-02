Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbeEBKOC convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:14:02 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:51937 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750942AbeEBKN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:13:59 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRWlGSWpSXmKPExsUSt3OpsW5q/8s
  og/Y56hanWvawW0y7s5vV4srFQ0wWUx8+YbNonDGf1eLblQ4mi8u75rBZdO7qZ7XY8H0towOn
  x4bPTWwerZf+snnMbrjI4rFz1l12j02rOtk89r1dxuaxfstVFo/Pm+QCOKJYM/OS8isSWDNWv
  //IVHCBt6Lz2TaWBsbfXF2MXBxCAksYJbYeOcTaxcjJwSZgITH5xAM2EFtEIEKi495lNpAiZo
  EpzBL9y/6zgySEgRJrl91jgiiKlGhcdogZwnaS6FtxBsxmEVCRaPi2EWwor0CAxNxLD1khtm1
  ilNh2bAIjSIJTwEjiw4kZLCA2o4CsxJfG1WDNzALiEreezAdbICEgILFkz3lmCFtU4uXjf6wQ
  trzE9m+/2SFse4nX996xQNj6Eo8eP2KEsA0lVk07ABU3l9iwbCc7xHwdiQW7P7FB2NoSyxa+Z
  oY4VFDi5MwnLBMYxWchOWMWkpZZSFpmIWlZwMiyitEiqSgzPaMkNzEzR9fQwEDX0NBY10TXwk
  QvsUo3SS+1VDc5Na+kKBEoqZdYXqxXXJmbnJOil5dasokRmBYYgGAH4/HpKYcYJTmYlER5V/m
  +jBLiS8pPqcxILM6ILyrNSS0+xCjDwaEkwfuoFygnWJSanlqRlpkDTFAwaQkOHiUR3sw+oDRv
  cUFibnFmOkTqFKOilDivBkhCACSRUZoH1wZLipcYZaWEeRmBDhHiKUgtys0sQZV/xSjOwagkz
  KsGMoUnM68EbvoroMVMQIs/f30OsrgkESEl1cDoZJyl2x70//Zz5/Mnzvhvd2Y4rndzikGY0S
  mmBbvmqH+TsO38uDz85eNIqcV/83yUOOSZzYrzZZv+ly02cL9s9EJ39t2eWeLLfZ+p5/8rtMt
  0Mr5X2HUodPFlm+aCN9+OPvvV/0RR+IaP9cv6GRcb3We8fP+4Za/kUlfuLbkXP7G+jxfPZJBR
  YinOSDTUYi4qTgQAjtv71oUDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-37.tower-246.messagelabs.com!1525256037!198845!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Mark Brown <broonie@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC: Akshu Agrawal <akshu.agrawal@amd.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] ASoC: da7219: read fmw property to get mclk for
 non-dts systems
Thread-Topic: [PATCH v2] ASoC: da7219: read fmw property to get mclk for
 non-dts systems
Thread-Index: AQHT4GUsuHphZND160Sqg+RURjmwB6QZqjfggAGgMwCAAO2sQA==
Date: Wed, 2 May 2018 10:13:55 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E9782@SW-EX-MBX01.diasemi.com>
References: <1525080203-18947-1-git-send-email-akshu.agrawal@amd.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E93BC@SW-EX-MBX01.diasemi.com>
 <20180501205006.GE2714@sirena.org.uk>
In-Reply-To: <20180501205006.GE2714@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 02/05/2018 07:47:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 May 2018 21:50, Mark Brown wrote:

> On Mon, Apr 30, 2018 at 07:05:19PM +0000, Adam Thomson wrote:
> 
> > There is already a means via DT to specify the MCLK for a device using the
> > generic clock DT bindings, and this driver already uses that. Should ACPI not
> > have something similar to that which is generic, rather than adding device
> > specific bindings/properties to achieve the same? There will be other drivers
> > that will want to do the same.
> 
> There's a lot of things that ACPI *should* do but doesn't - it's a bit
> of a shambles how ACPI standards get defined and what's there is not
> really intended to handle systems like these semi-embedded ones.  One of
> the big gaps in ACPI is that it has no handling at all of clocks, that's
> supposed to be done transparently by firmware in the ACPI model.  What a
> lot of the embedded Intel people have been doing is coopting the DT
> bindings wholesale for ACPI systems but that has problems when you get
> into areas which should be handled in some way on ACPI systems like
> power and unfortunately clocks are kind of power adjacent so might be a
> bit sketchy here.

Yes I was aware that previously that was the case, although have not followed
this for a while. It just feels here that we should aim for something more
generic rather than a device specific property/binding, if possible, as that
feels messy to me and I'm sure other drivers could take advantage of this as
well. I've not looked at the clock code in too much detail though, at least with
regards to this area, so not sure how feasible that is.

As a suggestion for ACPI would it be possible to re-use the 'clock-names'
property and add something in the framework to handle this?
