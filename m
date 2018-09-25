Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6D0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E7021480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E7021480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeIYNTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:19:20 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41769 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeIYNTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:19:20 -0400
Received: from [192.168.178.69] ([109.104.48.51]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mkn8B-1fLl802b8x-00mIcw; Tue, 25 Sep 2018 09:12:27 +0200
Subject: Re: [PATCH v2] staging: vc04_services: Update TODO re: arm64
To:     Aymen Qader <qader.aymen@gmail.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20180924224835.32539-1-qader.aymen@gmail.com>
 <20180924233426.32609-1-qader.aymen@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <34086ca9-758f-5228-2acb-04915c2e148d@i2se.com>
Date:   Tue, 25 Sep 2018 09:12:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924233426.32609-1-qader.aymen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:vhkbAbcqpTqwkMv5yUlTojn75dk17X7TBrKSjV8XuJi1vPWrfX3
 GQ13VR54dvz33vfKYZIEljaN4rhGjBBiGnMp2RQ7j04MxXTQ4GtDMWChhvJ1ORzKlpG+xBQ
 e5tJlR0VFRzVfCdO/PDF428GJvK5teCI9zkvlLyP6du7q9WHN5J9lK+DP+k0ZK7Wcw+vz7c
 pt+84u6pPjGznhiqe4Xzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kTJkFWCNCzw=:pOMXE2BlXcgVzcFa78esgZ
 IGbKTYsTxsUT94JhXYeHpLMtylTbok80W6gR6JI+xfURM89pVyne3u3C7O49PPmtoxxhBQgoj
 3jZLDsJZMpZ2zflLHgegJh/SoZ1YaSPiFuxc6YMIFKxr7yqBJ7SMT/gJPKN6qXezgT8lYLARL
 7Pz2ntWNxQ4/HSaR8WSjm8yqaJVk0M9hup7vXjvAtZ95hHI3+lO2xtcqoDI2GTF3YUXzDh7Gl
 z5vp9imRAg+g4a6kVRuIA6LYHHV7RaEC0bE0XBx7N5UpSMm8WLddjvJaew7Alh0jf+QPBZ0C/
 ypN9ZPIn5s8uFpQYqVFJN27iiJ5jH8Rl+OdzmToQlaD0tP+nkVX/e5Mq5eOK8QL0SIvHeDGDm
 BTfWY4gAqRZyiyLoYLzLrucWKjxfDzMCI+nbIVeCTpI9fkWGB9D5otRDk06ZKZOlaxPNFbncE
 M2Z+/7GAsox17cM7cB91ncRoUiF+P1gC03QDby7OPA0742kMqBoXdpjJHcug0dVp7xg9Ey+O/
 dMNWBftwgWEWkaekcuW+BXMwd8XmRyKq7Rz9Wf7JHncAeS3bU02bngIC9aPZ+IKRvn5i8S6AF
 WacNULK5xOuxqPyc5A3zKRMHey30CgmYiKA8n7EpdEo48boleX0iXjdW0ZlOuyKXGiejS1CxO
 suyRuh6rK4HRUl63Zr+VBdpI6uY+Qa2JE1bhzklZeDEJFxF8ReQSR2/Y6NPkfqaMZ1VLgvUxN
 cq6hDybtQOKl7Kk6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Aymen,

there are more than one TODO file in vc04_services (contains 3 drivers),
so here is my suggestion for the subject:

staging: bcm2835-camera: Update TODO

Am 25.09.2018 um 01:34 schrieb Aymen Qader:
> Remove the TODO item to remove manual cache flushing from bulk_receive.
> This was previously done in this commit:
>
> (7e8dbdea) staging: bcm2835-camera: Remove explicit cache flush
> operations

please use this format, which should also make scripts/checkpatch.pl happy:

commit 7e8dbea41032 ("staging: bcm2835-camera: Remove explicit cache
flush operations ")

>
> Also remove the unnecessary asm/cacheflush.h header.

This doesn't match to the subject. Maybe a separate patch would be
better here.

Thanks
Stefan

>
> Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
> ---
> v2: Make commit message clearer
>
>  drivers/staging/vc04_services/bcm2835-camera/TODO         | 6 ------
>  drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 1 -
>  2 files changed, 7 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/TODO b/drivers/staging/vc04_services/bcm2835-camera/TODO
> index cefce72d814f..6c2b4ffe4996 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/TODO
> +++ b/drivers/staging/vc04_services/bcm2835-camera/TODO
> @@ -15,9 +15,3 @@ padding in the V4L2 spec, but that padding doesn't match what the
>  hardware can do.  If we exposed the native padding requirements
>  through the V4L2 "multiplanar" formats, the firmware would have one
>  less copy it needed to do.
> -
> -3) Port to ARM64
> -
> -The bulk_receive() does some manual cache flushing that are 32-bit ARM
> -only, which we should convert to proper cross-platform APIs.
> -
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
> index 51e5b04ff0f5..6e5c1d4ee122 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
> @@ -21,7 +21,6 @@
>  #include <linux/slab.h>
>  #include <linux/completion.h>
>  #include <linux/vmalloc.h>
> -#include <asm/cacheflush.h>
>  #include <media/videobuf2-vmalloc.h>
>  
>  #include "mmal-common.h"
