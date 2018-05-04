Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeEDTrC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:47:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:59139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751709AbeEDTq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:46:59 -0400
Message-ID: <1525463210.622.1.camel@gmx.de>
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name
Date: Fri, 04 May 2018 21:46:50 +0200
In-Reply-To: <20180504171701.6876-1-paolo.valente@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Nr2dH2KoxjYNOE95hOdJlxmL/UUWIMU2h57A3O2RDvMluW3c4VO
 8OlGn0Fqu48U2ZjN0i9nawvJdFXayKKSIzKY0lfS1cAxTuS4dFy5twSdrx1r6RApiBnZHNH
 uN3WiG1Wzd+mmqPzdjzonE7FyTV4tUpQ4piFy5ErNIv8nkrRWyDzJRwTaFFs3UEuOd3kXvt
 KObE+eRm/vCBUlK9zFgtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p/Qs1B+bCiE=:jt7riObssn0UDSZ/QMOuix
 /hofanCrOEVC0uo4ad3dYhLXtGnCPeqNYxT3oObgqG06lvRUmnO4rnL8MHrtXQuX/qdshpZ5f
 WG9vHxm4o+nTxDictWUYElBubqaWYy2hS3RadylNUcmq6FKFykGyKwkYfADl7QyzpcxAYihil
 QypCuiWV/A9vxfTz4mGRoNN6h6gE6PmmsqshFdmgAsdjCEJ4SBUPi6c7TI6t37UyikMwFNolf
 OgtwEZQHdSNvLhb6fEnJ93rMQhyLh+ezXVFldNqZUtaLp/aChAUcmEm6xkgWG8eyokBriGJPT
 5V6tX6Ji01b8P5lj7pM8mP0sV20+w5COnoG8ExbPUszQzBjEuDmNk3ds0E44VCI384xQBuOi1
 Cp3q1GIera9NtyHR8uYJXWAV0EKn8cw+9cVdMKk5J9hduiMPWF5p7Yid9AAVjQk+FgtCaVwir
 QKJXsFYf1FYCqItnYOB6asIP6vEx8Qn1iM1JXbOJS+8ShLwhfcUyU8CqC/lHPb16tzs6v785Q
 +i59xhH8WnpAz+blrU8tT94BZ1DaXijHWrXyA9vbYVouboUHeXAs55pA3zzz+cVK1cznHesi0
 RpARij26IhfYY6KicuVkGzAdyPKlPSmp9Wf3COCAFSoaSgoi0s3AIF9DgwOsezSOH/qwc+PEV
 7lH9RMyXEbz5fj+8+sS4Litz9ZjgD0pErTu4b4gznC0piLdAMv+bglwIHib//FlsuSefZ6vY0
 BZ0/EjjIhtJ/NVJ9ChRMss8JOLWd3EroZrKT4kI552EBR3SDCwXVJWDKED76FzVPnzGa2gQoB
 VGqI0a2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tentatively, I suspect you've just fixed the nasty stalls I reported a
while back.  Not a hint of stall as yet (should have shown itself by
now), spinning rust buckets are being all they can be, box feels good.

Later mq-deadline (I hope to eventually forget the module dependency
eternities we've spent together;), welcome back bfq (maybe.. I hope).

	-Mike
