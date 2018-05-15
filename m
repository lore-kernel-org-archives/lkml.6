Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeEOKWo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:22:44 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54222 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeEOKWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:22:39 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180515102236euoutp023816b03eca1d0bac54fa52d526820d33~uyk1Dk3nN1820518205euoutp02w
X-AuditID: cbfec7f4-713ff700000043e4-99-5afab4ebecd3
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 14/18] fbdev: modedb.c: fix a kernel-doc markup
Date: Tue, 15 May 2018 12:22:34 +0200
Message-id: <4109551.rZs3yKu93M@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <a712d724d034cedeab76335071f916808db77e7a.1525684985.git.mchehab+samsung@kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djPc7qvt/yKMpj41MziyYF2RosrX9+z
        WSxsW8JicaLvA6vF5V1z2Czef+pksthxahGzA7vH5hVaHptWdbJ53O8+zuSxuG8yq8fnTXIB
        rFFcNimpOZllqUX6dglcGcdX3GIt6GWrOLxhEnMD42LWLkZODgkBE4mrl2+zdDFycQgJrGCU
        +HZrLjOE85lRYnLzMxaYqtldx6ASyxglPp1ohWr5zShxa8pcRpAqNgEriYntq8BsEQEziZPn
        jrKBFDELvGSUWH7qD9hCYQFniTON74BsDg4WAVWJO6+kQcK8ApoSu2Y9ACsRFfCS2LKvnQnE
        5hRIljjZ848dokZQ4sfke2AXMQvIS+zbP5UVwtaROHtsHSPILgmBHWwSl/reQp3tInHn5hxG
        CFtY4tXxLewQtoxEZ8dBJoiGZqCnd+xhhkhMYJTYs14IwraWOHz8ItQGPolJ26YzgxwtIcAr
        0dEGVeIhcej/Sqj5jhLfp9xmhITKC0aJtfuWsUxglJ2F5PBZSA6fheTwBYzMqxjFU0uLc9NT
        i43yUsv1ihNzi0vz0vWS83M3MQITxel/x7/sYNz1J+kQowAHoxIP744ZP6OEWBPLiitzDzFK
        cDArifDuNgIK8aYkVlalFuXHF5XmpBYfYpTmYFES543TqIsSEkhPLEnNTk0tSC2CyTJxcEo1
        MIpyVN5LWfggd0+F2VYhzsZT6RszJ8679ubGNYnC9/pu17ZK6sioepX1f81a/qrz2K2em3Nu
        +yr/6zyt7vzolL+SwWQ/gUWmBZqVJXmeVx5v37LwuPyxZz783WWOSf/28POopFau6sx22GSl
        ssP2O7NF0b1rB86bnp2zRn/Tpft1zVuNpYujnyixFGckGmoxFxUnAgDdCNbMEAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsVy+t/xq7qvt/yKMvi7S8ziyYF2RosrX9+z
        WSxsW8JicaLvA6vF5V1z2Czef+pksthxahGzA7vH5hVaHptWdbJ53O8+zuSxuG8yq8fnTXIB
        rFFcNimpOZllqUX6dglcGcdX3GIt6GWrOLxhEnMD42LWLkZODgkBE4nZXceYuxi5OIQEljBK
        7D72jw3C+csocfb3FyaQKjYBK4mJ7asYQWwRATOJk+eOghUxC7xklNjYtB5slLCAs8SZxndA
        NgcHi4CqxJ1X0iBhXgFNiV2zHoCViAp4SWzZ1w42k1MgWeLgz3csEMteMErcPHKADaJBUOLH
        5HssIDazgLzEvv1TWSFsLYn1O48zTWDkn4WkbBaSsllIyhYwMq9iFEktLc5Nzy021CtOzC0u
        zUvXS87P3cQIDOZtx35u3sF4aWPwIUYBDkYlHt4dM35GCbEmlhVX5h5ilOBgVhLh3W0EFOJN
        SaysSi3Kjy8qzUktPsQozcGiJM573qAySkggPbEkNTs1tSC1CCbLxMEp1cAoeJo/tWz91Tm+
        f4y8VdMs9v5/+i6c9Q2/5TWdRX9NDv8/l/XousyVaouesCwl1hVntd/tZjKofvoypFXk9fH/
        Z0UqFZXX9XMas4ee+lWrevaGc8GjA/VPnntstLU4Jvvj9yRvjmeyEp48DyrupJVMdLNx7Nz3
        8vbLH6se/rqp3nDvK6vGncCPSizFGYmGWsxFxYkATJiV3GICAAA=
X-CMS-MailID: 20180515102235eucas1p196740463cc65cec23bada9202c66e6c8
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180507093605epcas3p332cb6a795335f41109dbb9544b1c4165
X-RootMTR: 20180507093605epcas3p332cb6a795335f41109dbb9544b1c4165
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
        <CGME20180507093605epcas3p332cb6a795335f41109dbb9544b1c4165@epcas3p3.samsung.com>
        <a712d724d034cedeab76335071f916808db77e7a.1525684985.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, May 07, 2018 06:35:50 AM Mauro Carvalho Chehab wrote:
> Use code blocks to avoid those warnings and make it look nicer.
> 
> 	./drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
> 	./drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
> 	./drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
> 	./drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
