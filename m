Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbeDMJIZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:08:25 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:27171 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752446AbeDMJIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:08:23 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180413090821epoutp0487f54fdc6dffbed736b554cab3b3df40~k8620FEF_3092030920epoutp041
X-AuditID: b6c32a35-139ff70000000fee-f5-5ad073843ff9
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Fri, 13 Apr 2018 11:08:18 +0200
Message-id: <3546651.LUmDXQgY88@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <5afdb571-8aaa-941f-ff4f-7c4b031b5efb@linaro.org>
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWy7bCmnm5L8YUog8WXxS3mfZa1mH/lGqvF
        5V1z2Cw+9x5htLh06CKTxZOHfWwWj/resjuwe+ycdZfdY/Gel0wed67tYfM4MeM3i8fnTXIB
        rFFcNimpOZllqUX6dglcGTdeP2Qr+CZSseiCWwPjMoEuRk4OCQETiSkdSxi7GLk4hAR2MErs
        vfiFHcL5zihx6vgqdpiq+dfXMUMkNjBK3DozgxXC+coo0dq3mg2kik3ASmJi+ypGEFtEQE+i
        8X0bE4jNLPCFUeLhTX4QW1jAQaJhwzUWEJtFQFXiffsUZhCbV0BTovficbBtogJeElv2tYP1
        cgrYSbRsPcMCUSMo8WPyPRaImdoST95dYIWwNSVefJnEAnKQhMABNollv/YwQpztIvFpzkQm
        CFtY4tXxLUALOIBsaYlLR20h6psZJb7t2MMMUTOBUWLPeiEI21ri8PGLUAv4JN597WGF6OWV
        6GiDKvGQmHj4MNR4R4lnkx6yQQLlBqPEoUvbmCYwys5CcvcsJHfPQnL3AkbmVYxiqQXFuemp
        xYYFhnrFibnFpXnpesn5uZsYwSlCy3QH45RzPocYBTgYlXh4FSrPRwmxJpYVV+YeYpTgYFYS
        4b1ZcCFKiDclsbIqtSg/vqg0J7X4EKM0B4uSOO9TnzNRQgLpiSWp2ampBalFMFkmDk6pBsZ6
        rwmHV805lTC5ddqUTUJq1b/3TPXRSOjdG1u6PO1t/4dXsoVJ0pkb6yw/vdhxoirWV884YrXf
        wU2CH/4lRk/bOnfyo79bog9POLzx9CN9A/+DtTMSHbIfnr1/7mtieoqOQGuHyL/2hMuPF2Vt
        n/PIMkn4u4jA138bfzK+7S8/n1Rg9cc2dr+JEktxRqKhFnNRcSIAjLuYLQ0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsVy+t9jQd2W4gtRBvsPsVnM+yxrMf/KNVaL
        y7vmsFl87j3CaHHp0EUmiycP+9gsHvW9ZXdg99g56y67x+I9L5k87lzbw+ZxYsZvFo/Pm+QC
        WKO4bFJSczLLUov07RK4Mm68fshW8E2kYtEFtwbGZQJdjJwcEgImEvOvr2PuYuTiEBJYxyix
        eX8/C4TzlVHi8s7LbCBVbAJWEhPbVzGC2CICehKN79uYQIqYBb4wSiw+sIcVJCEs4CDRsOEa
        C4jNIqAq8b59CjOIzSugKdF78Tg7iC0q4CWxZV87E4jNKWAn0bL1DNS2JkaJbct2QjUISvyY
        fA9sELOAtsSTdxeAFnAA2eoSU6bkTmDkn4WkahaSqlkIVQsYmVcxSqYWFOem5xYbFRjmpZbr
        FSfmFpfmpesl5+duYgSG9LbDWn07GO8viT/EKMDBqMTDq1B5PkqINbGsuDL3EKMEB7OSCO/N
        ggtRQrwpiZVVqUX58UWlOanFhxilOViUxHlv5x2LFBJITyxJzU5NLUgtgskycXBKNTAyT+bz
        //Qhq9WpXyJEMumT4AQNzyb7jbvqTsxObj0wf9r03qe1EasFbE/rTV6/7uS0OhWz3XUpj150
        GUzuktQ/NVnuT3c8d6JyvGzckUfF4pevVAQ99f5tbXnr+HydRz5rgpYKv20+/LGN4ZthoULf
        voXn5qyx+/Hw91y/NlnB5oeHMrUNDiUpsRRnJBpqMRcVJwIAurBv8mUCAAA=
X-CMS-MailID: 20180413090820epcas1p17dd97e3815909e0714f9d5a80eb82be9
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180413090820epcas1p17dd97e3815909e0714f9d5a80eb82be9
X-RootMTR: 20180413090820epcas1p17dd97e3815909e0714f9d5a80eb82be9
References: <1523436077.16235.5.camel@intel.com>
        <2944702.qKZ0LXufY7@amdc3058>
        <5afdb571-8aaa-941f-ff4f-7c4b031b5efb@linaro.org>
        <CGME20180413090820epcas1p17dd97e3815909e0714f9d5a80eb82be9@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3D98T7N019394

On Friday, April 13, 2018 11:00:43 AM Daniel Lezcano wrote:
> On 13/04/2018 10:55, Bartlomiej Zolnierkiewicz wrote:
> > On Friday, April 13, 2018 01:39:05 PM Zhang Rui wrote:
> >> Hi, Eduardo,
> >>
> >> On 四, 2018-04-12 at 21:08 -0700, Eduardo Valentin wrote:
> >>> Hello,
> >>>
> >>> On Thu, Apr 12, 2018 at 09:55:19AM -0700, Linus Torvalds wrote:
> >>>>
> >>>> On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.com>
> >>>> wrote:
> >>>>>
> >>>>>
> >>>>> could you please illustrate me what the kconfig & warning is?
> >>>> Just "make allmodconfig" and the warning is about a uninitialized
> >>>> variable.
> >>>>
> >>>> Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell
> >>>> history
> >>>> is to be believed.
> >>>>
> >>>>                 Linus
> >>> Yeah, this has also passed my local compilation error. Somehow my
> >>> gcc4.9
> >>> is not catching it. Using an older gcc (gcc4.6) does catch it.
> >>>
> >>> Anyways, given that the conversion functions are written to cover
> >>> for unexpected cal_type, the right way of fixing this is to rewrite
> >>> the conversion functions to allow for returning error codes and
> >>> adjusting the callers as expected.
> >>>
> >>> Rui, bzolnier, please consider the following fix:
> >>>
> >> as it is late in this merge window, I'd prefer to
> >> 1. drop all the thermal-soc material in the first pull request which I
> >> will send out soon.
> >> 2. you can prepare another pull request containing the thermal-soc
> >> materials except the exynos fixes
> >> 3. exynos fixes with the problem solved can be queued for -rc2 or
> >> later.
> > 
> > Could you please just merge the obvious fix from Arnd instead?
> > 
> > [ it was posted two weeks ago and ACKed by me ]
> > 
> > https://patchwork.kernel.org/patch/10313313/
> 
> I'm not sure these are correct fixes.
> 
> The change 480b5bfc16e1 tells:
> 
> "There should be no functional changes caused by this patch."
> 
> but the fix above returns 0 as a default value instead of '50' or '25'
> for the 5440 and that impacts the threshold etc ...
> 
> IMO, the correct fix would be to define a default value '50', override
> it at init time to '25' if it is a 5440. And then the variable 'temp'
> and 'temp_code' get this value in the default case.

It is okay to return 0 because this code-path (the default one) will be
never hit by the driver (probe makes sure of it) - the default case is
here is just to silence compilation errors..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
