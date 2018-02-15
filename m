Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031597AbeBONBH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:01:07 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:39327 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030561AbeBONBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:01:05 -0500
From: Lukas Senger <lukas@fridolin.com>
To: giometti@enneenne.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pps-gpio: implement echo pulses
Date: Thu, 15 Feb 2018 13:59:19 +0100
Message-Id: <20180215125921.29494-1-lukas@fridolin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <ee4fdd16-0343-1a01-63a7-06046026659a@enneenne.com>
References: <ee4fdd16-0343-1a01-63a7-06046026659a@enneenne.com>
X-Provags-ID: V03:K0:y7ItheQZqI3XEpIT9ys1k3fsUhjmVaKCgJUXGXu0HwzCCnRKGEy
 x1nmf3Ci617+HS8IwZkwbW+0QSh+2X6zL3otTCamcqhjs0jT1SoqJ7D+piqorNLmFVa6wSB
 Tj1qMalKMu9NZrTb5qAe23/gIzBn2clspEJr6Ksz/t26Dk8n7LuHvBRmTdly9SRfgnQbudu
 WR+7gL9PndecO2tYVxAAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5JWdw4gcXrE=:7j0oeZSchbA3cxeJv0NFy9
 wO17UWH9p5HPamESKY0fonsKEFBorebwxWvhYgY4W6uyQsWNpmb0PPhADov4c9/pmRj863lpe
 hYGLhKFVCaa2v+Jgb/RWPwbxoJp0p7ZraJ5bIL/2Me+JskZeK4FM+8S409LIGGru72szjE7Fv
 89dOTTyvGTs9ocsBx4wbpp3rBTODGbESaisUdFsNQS3vqpP/fFTkxB/PjjtWED+1YR7NwOdHn
 KTn3/l6Y1yapC62SiamGcgDDw1cVDZRuvjFUkAd9pAWtlhmu6SLFsUe11tSBGJO7y5C2AV8k2
 REd7eQIRT/yQATr11A+BwRmCw5upLkNXOK8Do7AYSMT9pIpOvvIjZe4VzXNxcpxVAGh4FFZCU
 XXQtgQUZ4ntEyC66G3PIuaq7Bbevb8eTn7SxiHPfiGZArzuHWn8Qo3eh7Er4s/hyx0RTsOtVx
 lbpzPCTVn96DEBUHLkvCbeIKW8We8MO9z2tI/OOPTFm7oFh+MtZdaZmRiukAToeXQ8xWXrlmr
 Pa1vB2EkVuX5rE1hVjHUS1sXlJCK1LM+IZ+5sN46CtPRKVY5xsHS2lJzlwaS954n8a0QDBaOI
 rYqWrO56OWmdregyBtICvMeEnM34MsBQKVHPdcCxQWF3jP47WwYLqAPqT/xJTi62dg8IIuaMg
 PpEKn6ehKMA86B/Q4eODJugirZfgvHrk0x5Wk19ioF+Ko2t9PK3+1Z8c0a9GT+fBBfVP42ax6
 KilWKMu12f8lv2vTrYgH7cxiqUEsXrzz+UiOEw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> No hardcoded stuff please! :-D

I expected as much :) So I looked into it a bit more and came up with
the patch below. It works for me but I'm unsure about two things in
particular:

In the __overrides__ section of the *.dts, why does gpiopin set reg and
should echopin set this as well?

In pps-gpio.c:135 how is pdata in the first part of this if-statement
supposed to know about these values?

Thanks,
Lukas
