Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753914AbeEHEvj convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 00:51:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:59757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753540AbeEHEvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 00:51:37 -0400
Message-ID: <1525755090.24338.1.camel@gmx.de>
Subject: Re: bug in tag handling in blk-mq?
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Tue, 08 May 2018 06:51:30 +0200
In-Reply-To: <84145CD7-B917-4B32-8A5C-310C1910DB71@linaro.org>
References: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
         <7760d23b-7a4c-a645-1c7a-da7569bb44dc@kernel.dk>
         <84145CD7-B917-4B32-8A5C-310C1910DB71@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Hk17jElSXyi3HID4jPtNsRXIU8VENqhwY5uDtTnkW3lo8viJ8B0
 0D9GIbCVAW7ADkTcN49cKeXy0aQAgRKaSUTgba269wRuJsaEH0B9BtnFzPRJzHevfQC4+Xr
 eKwm65eplHYu6Mjwa7P4GO7EL/egBucqbI8s4GFsZS99PC2axmWx+yg7sPjnZzPLsu6NzZg
 XGdMacObyqfRYYRsVyJHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zbBiMfXGLS0=:vL+qb5+3xMCq6Wh4mjRzvY
 IXXk7deCuQbbkTY3d9EwHV+1xido9QM2x824wOAhCP8pEcE+ji83cseUImPeA4WsbAxWtW0td
 6Xx8ZmHKuhNbYYEeowdfvnAHwWNj2p/EWX6L7ThqjBZgCg/JRycSHDtnwrx6QCtWQmjVmvaAZ
 H3cdfaASyNcbKd1w0Qt+g6MaJ8DcF6t5yzj/wC2baY2/WdaXMdTpiwd7L8SF7mUlLQieZrfpB
 xcBp5TveR+QSoFDKJeL/TAnq3MJLyiTzjeQgMD4ZI9OzcHikJGWfp/ByehX6A94KB5J7AlEcW
 xx5whA/kfoKRugBo51puZH7rRwrz/nBaKeNAyn3Y+LNcTsvgVYMo6UPH/34Fvv68ERAkgpAi0
 k3KQKyIlqQJl3cuDc4oI9B+T8YMaVd0dchJKfm+l/yq7IchXiN1s1er2eA1brwSvjgLLWVo/I
 /tcZUILGpnjPSvAAd9lXiW+fAYRascBk8xi1HENXKGd818atToBvG9cZ1QVAJT02QkGbItzeZ
 3iFsW7PPV6z89IdXt15F3aMhUAl/ksRInPSUvT1GeuS7jNo+g0FGKRNi+h810pm9D/wVACvN1
 3IaTALXv1an6Si/VMwjAH/C+R+TfGpM1SF19YL6DKbZWVjSEQkCvWAid8ar2o3xVw3jSmReNX
 CRkZcnM7dYTHIyFqanayKA5aW97GwQyn5ZvnFWhHPVabn/qDH+9VOKlwe5Ob3t4jU9IuFifOf
 k/T7SL+e5ripqnIpIDogJ+ekSStSM54U8QfTcz243yKU58BJCTKG/FT45GRnTYObeYelJ5jL/
 P7UVxZ0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-07 at 20:02 +0200, Paolo Valente wrote:
> 
> 
> > Is there a reproducer?

Just building fat config kernels works for me.  It was highly non-
deterministic, but reproduced quickly twice in a row with Paolos hack.
  
> Ok Mike, I guess it's your turn now, for at least a stack trace.

Sure.  I'm deadlined ATM, but will get to it.

	-Mike
