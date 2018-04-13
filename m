Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754298AbeDMKlZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:41:25 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:51847 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbeDMKlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:41:23 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180413104121epoutp01d046da9750cd99590ca6c25adb10f567~k_MDhlAAR1229312293epoutp01D
X-AuditID: b6c32a36-f57ff70000000fc2-85-5ad089519ee5
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Fri, 13 Apr 2018 12:41:18 +0200
Message-id: <10298074.ogKH1ypqfx@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <3b41052a-233d-9992-223a-d16f48295905@linaro.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7bCmgW5g54UogzdnWS3mfZa1mH/lGqvF
        5V1z2Cw+9x5htLh06CKTxZOHfWwWj/resjuwe+ycdZfdY/Gel0wed67tYfM4MeM3i8fnTXIB
        rFFcNimpOZllqUX6dglcGUtebWYu2M9T8e9gI2sD42POLkYODgkBE4k3x/O6GLk4hAR2MEpc
        u9vPCOF8Z5RY9fEuSxcjJ1jRmtf/mSASGxgl3u6aygbhfGWUmPN0BitIFZuAlcTE9lWMILaI
        gJ5E4/s2JhCbWeALo8TDm/wgtrCAg0TDhmtgU1kEVCX+HtoGZvMKaEmc/bEebI6ogJfEln3t
        YL2cAnYSR+a/hqoRlPgx+R4LxEx5iX37p7JC2DoSZ4+tY4S4dA+bxPUnMRC2i8S32Y2sELaw
        xKvjW9ghXpaWuHTUFuR+CYFmRolvO/YwQ9RMYJTYs14IwraWOHz8ItR8Pol3X3tYIXp5JTra
        oEo8JH6s3sMGYTtKLD7VDFYuJHCDUWLLxMgJjLKzkFw9C8nVs5BcvYCReRWjWGpBcW56arFh
        gZFecWJucWleul5yfu4mRnB60DLbwbjonM8hRgEORiUeXoXK81FCrIllxZW5hxglOJiVRHhv
        FlyIEuJNSaysSi3Kjy8qzUktPsQozcGiJM771OdMlJBAemJJanZqakFqEUyWiYNTqoFRsbrw
        N+/Wk24B2zuv3RNI2OKTxpJatahihUjEuv7tHFZSy7bsDorJqGZc/mn3x+3aEcvMZ6cfX5Rz
        poz3aO/xw8btmpIR+6evu12We+xy9CfN/fEr95zn8zraEraq6GJ02fqsz1daVnZtbi124p3u
        +fd53M/Al5Kekx9F7S7fVd34bMXXgHNPlFiKMxINtZiLihMBPyvaXAsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsVy+t9jQd2AzgtRBoe3GlvM+yxrMf/KNVaL
        y7vmsFl87j3CaHHp0EUmiycP+9gsHvW9ZXdg99g56y67x+I9L5k87lzbw+ZxYsZvFo/Pm+QC
        WKO4bFJSczLLUov07RK4Mpa82sxcsJ+n4t/BRtYGxsecXYycHBICJhJrXv9n6mLk4hASWMco
        8ar1HDOE85VR4vC8LSwgVWwCVhIT21cxgtgiAnoSje/bwDqYBb4wSiw+sIcVJCEs4CDRsOEa
        WAOLgKrE30PbwGxeAS2Jsz/Wg9WICnhJbNnXzgRicwrYSRyZ/5oFYlsTo8SLxiZmiAZBiR+T
        74E1MwvIS+zbP5UVwtaSWL/zONMERv5ZSMpmISmbhaRsASPzKkbJ1ILi3PTcYqMCw7zUcr3i
        xNzi0rx0veT83E2MwMDedlirbwfj/SXxhxgFOBiVeHgVKs9HCbEmlhVX5h5ilOBgVhLhvVlw
        IUqINyWxsiq1KD++qDQntfgQozQHi5I47+28Y5FCAumJJanZqakFqUUwWSYOTqkGRlXH49ot
        b+o8n1ZoBgr9i9uVvLuy8eYrf39hHaflF5JVWhbLhe22Nwi++0H7TFuqxe1UyaSf/F1dz15w
        tCZ9rE/7wT3t1G7ZC1p3p/S4S+wWenLSzOImx44Hwbt9Y5480/u7//3MzKUBPbO5/svnmD/Z
        o3bjXOIE+VjeE3GFVgFOta8CHR53K7EUZyQaajEXFScCAEJDRD1oAgAA
X-CMS-MailID: 20180413104120epcas1p319b9e78b025cb68f810f047c67a48362
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180413104120epcas1p319b9e78b025cb68f810f047c67a48362
X-RootMTR: 20180413104120epcas1p319b9e78b025cb68f810f047c67a48362
References: <1523436077.16235.5.camel@intel.com>
        <4212243.RcCUWlsaar@amdc3058>
        <3b41052a-233d-9992-223a-d16f48295905@linaro.org>
        <CGME20180413104120epcas1p319b9e78b025cb68f810f047c67a48362@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 13, 2018 12:30:04 PM Daniel Lezcano wrote:
> On 13/04/2018 11:28, Bartlomiej Zolnierkiewicz wrote:
> 
> [ ... ]
> 
> >>> It is okay to return 0 because this code-path (the default one) will be
> >>> never hit by the driver (probe makes sure of it) - the default case is
> >>> here is just to silence compilation errors..
> >>
> >> The init function is making sure cal_type is one or another. Can you fix
> >> it correctly by replacing the 'switch' by a 'if' instead of adding dead
> >> branches to please gcc?
> >>
> >> if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
> >> 	return ...;
> >> }
> >>
> >> return ...;
> > 
> > I'm not the one that added this switch statement (it has been there since
> > 2011) and I would be happy to remove it. 
> 
> Actually the switch statement was fine until the cleanup.

I don't see how it was fine before as the driver has never used the default
case (always used TYPE_ONE_POINT_TRIMMING or TYPE_TWO_POINT_TRIMMING).

Could you please explain this more?

> > However could we please defer
> > this to v4.17 and merge the current set of Exynos thermal fixes/cleanups
> > (they simplify the driver a lot and make ground for future changes)?
> 
> Regarding the latest comment, this can be fixed properly by 'return' (or
> whatever you want which does not get around of gcc warnings).

Do you mean that you want the patch with switch statement removal?

Is incremental fix OK or do you want something else?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
