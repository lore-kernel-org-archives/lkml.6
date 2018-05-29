Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933891AbeE2MlV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:41:21 -0400
Received: from ms.lwn.net ([45.79.88.28]:34716 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933565AbeE2MlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:41:18 -0400
Date: Tue, 29 May 2018 06:41:15 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] Documentation: document hung_task_panic kernel
 parameter
Message-ID: <20180529064115.6ed0a00f@lwn.net>
In-Reply-To: <53ad4158547699c2d35ba817394750dc2487158a.1526926625.git.osandov@fb.com>
References: <53ad4158547699c2d35ba817394750dc2487158a.1526926625.git.osandov@fb.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2018 11:18:17 -0700
Omar Sandoval <osandov@osandov.com> wrote:

> This parameter has been around since commit e162b39a368f ("softlockup:
> decouple hung tasks check from softlockup detection") in 2009 but was
> never documented.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Applied, thanks.

jon
