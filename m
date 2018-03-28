Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753714AbeC1Obk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:31:40 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:45197 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753116AbeC1Obi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:31:38 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180328143136epoutp01da596ac4f47eefddc795185f6a96da67~gHAhZYn4H1175811758epoutp01K
X-AuditID: b6c32a37-575ff70000000fe6-eb-5abba747e4f7
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Jingoo Han <jingoohan1@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: s3c-fb: remove dead platform code for
 Exynos and S5PV210 platforms
Date: Wed, 28 Mar 2018 16:31:33 +0200
Message-id: <1635191.86fAONqsAU@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <000001d3a5de$b9d2d080$2d787180$@gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7bCmga778t1RBic+61lc+fqezWLFl5ns
        Fif6PrBaXN41h81ixvl9TA6sHjtn3WX3uN99nMnj8ya5AOYoLpuU1JzMstQifbsErozpS6ax
        FZxgqdh64hJzA+N55i5GTg4JAROJxtn7mboYuTiEBHYwSuxp6mEBSQgJfGeUONUnBlO06MsN
        Noii3YwS887sg3K+MkpcOnsDrINNwEpiYvsqRhBbREBVouH8SVaQImaBZkaJzinnwRLCAukS
        d5+vBbNZgIpWf/sIZvMKaEpsufKJDcQWFfCS2LKvnQnE5hSwkLjTMxmqRlDix+R7YMuYBeQl
        9u2fygph60icPbaOEWSZhMACNomGE0fYIO52kei7OokdwhaWeHV8C5DNAWRLS1w6agtRD3Tc
        tx17oIExARgA64UgbGuJw8cvQi3gk3j3tYcVopdXoqMNqsRD4uCVvYwQtqPEmUl9jJBQWcko
        sXj7CuYJjLKzkNw9C8nds5DcvYCReRWjWGpBcW56arFhgbFecWJucWleul5yfu4mRnD8a5nv
        YNxwzucQowAHoxIPr8Wi3VFCrIllxZW5hxglOJiVRHjfawCFeFMSK6tSi/Lji0pzUosPMUpz
        sCiJ8wYEuEQJCaQnlqRmp6YWpBbBZJk4OKUaGPUM7t7s3O5rLLl0p6h53o/rJp2/uuod3/Wd
        aNz89q2eVtDPOX1HNnZXfFGcvo2v6Pa/RG0nHfZH4TtNlSzrfm4IqZLaK1YpVRiXaCmfGbG9
        pkRE2LNItv1p05wKyR9eV/pvBvmuYyw9WSO67sLeo2tOhNS+9zgWv+hddEOdHbe296tOg2xH
        JZbijERDLeai4kQATlaXf/sCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsVy+t9jAV335bujDG7f4LO48vU9m8WKLzPZ
        LU70fWC1uLxrDpvFjPP7mBxYPXbOusvucb/7OJPH501yAcxRXDYpqTmZZalF+nYJXBnTl0xj
        KzjBUrH1xCXmBsbzzF2MnBwSAiYSi77cYAOxhQR2MkpMuxTexcgFZH9llJh9YzMTSIJNwEpi
        YvsqRhBbREBVouH8SVYQm1mgmVFi4a+4LkYODmGBdInjO91AwixAJau/fQQr5xXQlNhy5RPY
        fFEBL4kt+9rBRnIKWEjc6ZnMCLFrNaNE+9vHzBANghI/Jt9jgZgvL7Fv/1SoXVoS63ceZ5rA
        yD8LSdksJGWzkJQtYGRexSiZWlCcm55bbFRgmJdarlecmFtcmpeul5yfu4kRGKzbDmv17WC8
        vyT+EKMAB6MSD6/Fot1RQqyJZcWVuYcYJTiYlUR432sAhXhTEiurUovy44tKc1KLDzFKc7Ao
        ifPezjsWKSSQnliSmp2aWpBaBJNl4uCUamCMXcMqW7bT8t3/C1YuG1uPWiU9+bzi4/2uMhef
        DJ+5E+212tKjAxxNThY5hz4LSted157pcE7Sjv1Dr9JHZXb9SS7eCcU+jxX32sg0V0V9uP9z
        +jWdLw8dXs46kSn2kieip2vteuucqvMTE/ZV7530gcGb9y63QsAGmQfRxrGCvtXxrwr3GSix
        FGckGmoxFxUnAgBtoJj/UgIAAA==
X-CMS-MailID: 20180328143135epcas1p27ec0d23e6bf9caf82fbd05e09fc29b2c
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180214120041epcas2p37afd51e693a9cad842e59128a77d45ac
X-RootMTR: 20180214120041epcas2p37afd51e693a9cad842e59128a77d45ac
References: <CGME20180214120041epcas2p37afd51e693a9cad842e59128a77d45ac@epcas2p3.samsung.com>
        <2621881.tniV7NOQqn@amdc3058> <000001d3a5de$b9d2d080$2d787180$@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, February 14, 2018 04:56:53 PM Jingoo Han wrote:
> On Wednesday, February 14, 2018 7:01 AM wrote:
> > 
> > Exynos5, Exynos4 and S5PV210 platforms have been converted to
> > use Device Tree and Exynos DRM driver long time ago.  Remove
> > dead platform code for these platforms and update Kconfig
> > s3c-fb entry accordingly.
> > 
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> 
> Acked-by: Jingoo Han <jingoohan1@gmail.com>

Thanks.

Patch queued for 4.17.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
