Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbeEFK7d (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 06:59:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:41627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbeEFK7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 06:59:30 -0400
Message-ID: <1525604359.28142.3.camel@gmx.de>
Subject: Re: [PATCH] x86: UV: raw_spinlock conversion
From: Mike Galbraith <gleep@gmx.de>
To: Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Date: Sun, 06 May 2018 12:59:19 +0200
In-Reply-To: <alpine.DEB.2.21.1805061225550.1685@nanos.tec.linutronix.de>
References: <20180504111459.24825-1-bigeasy@linutronix.de>
         <20180504111459.24825-2-bigeasy@linutronix.de>
         <alpine.DEB.2.21.1805061225550.1685@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zZSszfF8I4zrJpf0gsFGuT5ZkKmYk6ks7YHcPEQg8f4NpFF2Bod
 fia/8jv9KgHxFAjMbrfh69+eBYLRuX9zPiHcrb38sAiCsodLOuym3R9Qk508Jm6WkoALo1T
 UGWjosTxAQxXbj3sVzM0PZUGnHZsssKxSJcR3MiFVamszUrDnUG8KOTKwxKGaXQ7hJbwGhJ
 kV5KDL2Kv3WQ7NyPpHTmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fWNjvoFStD0=:fcaRW81dWwcSVXBudeZUHi
 aiF0zZFq2ZVJ5Pqc1n0bQihzN+B50A6/ImrjHuoMiqZ4iNtuAJOgIdx2NntiR8dCsO1Trs9pD
 285GIs21naM56bJDA3X3OaM2awirlPT9SJ+ngSdUx7QhBJTBzg9I9TklPOrAFYha4o0ER8Aci
 cjNC5Cg+i4dxWnYRj5YzsfN07S8PjjZLCRb8EgHu6JjPVBVbGm1flMI9tFd33XBeqLrrtybfO
 VXfFsW7nTgO49h16zfL84juFPuUnCEk8Aa3bPyYEFb3LqCIw+qxzZu+KnTQBmIRkjOk0zVcjL
 +vN+QBAkLHlUevyIm97Xo2EJdR0znq4mMdhzGyF38W2sBMzaFv9HgodWUQA8gCRgbJ4T17IG8
 JBo4cLCHPqEleo94Bv4u14WdKalyReF0c2jVwf0kQ6VY0gPvKEUH1eMwC2LErS+s6rHF3fdBn
 dF/4uxH0BK1ZkkeSqUkTT3iZUwCWbLQemIgNuigyWv+fOrWST3CkUhuaqhIif4EKAHH/DsyuV
 lq6UxscFHN3i4M747Mw51CPFD2wVq7I+x1fOJjCFO7ZqHgvupjJ6lAkjpZGx3f9VKhpffTzCA
 DZYQ6O5ZMiXgY+4BLFD1FOHr0kzKJ8HlLWHYJENfn7QCfHhhxB7xvofk06Yuzf6t9e+lsvcyC
 FH6BrsblhovfpuR39bfhGnqu6wqDbJIJ1xKyatQoeK/wS3T2tXoR60wLUVX2UvTfIMn8IHG5b
 XNnFMW3o0HhZzki87HWklrgpW9i7s1CJoeOcDvQ+C8P9o3Iuvu+YTAZbYHbe08/V00vU5zYHK
 seeUHT3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-05-06 at 12:26 +0200, Thomas Gleixner wrote:
> On Fri, 4 May 2018, Sebastian Andrzej Siewior wrote:
> 
> > From: Mike Galbraith <umgwanakikbuti@gmail.com>
> > 
> > Shrug.  Lots of hobbyists have a beast in their basement, right?
> 
> This hardly qualifies as a proper changelog ...

Hm, that wasn't intended to be a changelog.

This patch may not be current either, I haven't tested RT on a UV box
in quite some time.

	-Mike
