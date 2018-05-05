Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbeEEO4m (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 10:56:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:60237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbeEEO4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 10:56:40 -0400
Message-ID: <1525532191.5406.15.camel@gmx.de>
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
Date: Sat, 05 May 2018 16:56:31 +0200
In-Reply-To: <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
         <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
         <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9fBZx5B3466Hd4bRuR0oiYVGkR9iR31taevus3olmB1b56UtYBe
 qQ4r7VHdbJSo315kuYAILC7G9D0aEvSgqHxrgnEufkco5pnqSVsNVjyOwRJhTbt/UPUOYAX
 wQDBEYo/t5/jNGxkAAKUh9EfiFP0mM6nnbGkHgrdYjNRfEF0hKYn9fr2p28WSBBKvIm0YJY
 iQKKH4C1DIOYptXnREAbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E/mIgjWJ2vQ=:VPbFtFvoj1+q6s0XSigQq+
 65170Q5FSJUpSoEsZGczBsnuaDU6Bcx2nQXZLWDygqJ8I/0J+dheln4uRhCoPXDjxNFYQujfy
 KmRAF4qQS82VnRK4/8p60y0kei+BybmZ0rix1mjcZX5+gD4Ry9jXzoEA1wE3mwtCdQUF7tjOL
 2KijMJgsYaaC83rONE48K3pVW6Ywg1P1nxBkqHNuOKzMC3yceOjJTojxZakHFyXJw2ProIgSh
 AoZjbVl9SDbSPYmxl6RSyKv1YUiFORtfb/aRAYXnAfyJLibCTkWxH0PgxEZBX1BCVxpdAhjMj
 rBAI39FshqKVMrqimwmxFs414q6FfRYeq7oqyHXmZcrW5COKKm7fw0hjb/BBAsD2lD01oUuUm
 meaZTMAK2s1f/fBBgIC85+TyqwKHqcoHEj8z0GbCA+NQRRYL0VcYx98GIo5JYpVbzhPqpcaQ1
 cVtJWw9rmeH9m6Bm7ivsNpZloFy26nmM8y9hmpxopS/58C7oJ07PhuYRkLalsgLV/dVoAyGus
 ReF55NJDm9Um55Cbq+USSEft6LM5pdrh4pKX3AZBJE8wTgJkkXueXDzEKNfHjRIKSzbVXVnGp
 8Q1a/fhv83iOu7wIm+AP3eIgkPmLBTKhe8JBBfACu5hjhi1tXfDxc1wbe10w5vkCyUSzZ+nIc
 tUZ5JizPPgAiWNM4mk/8Jr9Xw2ONQ3U+poJAlgpj6qbK9K70UvjeDWeiVAzlDJb5HwDexL33s
 czP6AbOQyhmmFG4bW/B5K55tGOsfnCvIff9S9iJohwbf5gX7Q6XHM4SG3OEwovS6Anto2z51R
 x4C7/Jt
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-05-05 at 12:39 +0200, Paolo Valente wrote:
> 
> BTW, if you didn't run out of patience with this permanent issue yet,
> I was thinking of two o three changes to retry to trigger your failure
> reliably.

Sure, fire away, I'll happily give the annoying little bugger
opportunities to show its tender belly.

	-Mike
