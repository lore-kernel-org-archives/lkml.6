Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeBSA3m (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 19:29:42 -0500
Received: from ms.lwn.net ([45.79.88.28]:52268 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751780AbeBSA3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 19:29:41 -0500
Date: Sun, 18 Feb 2018 17:29:24 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] admin-guide: Fix list formatting in tained-kernels.html
Message-ID: <20180218172924.4a93ba8c@lwn.net>
In-Reply-To: <20180213223653.6437-1-j.neuschaefer@gmx.net>
References: <20180213223653.6437-1-j.neuschaefer@gmx.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018 23:36:51 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> Without this patch, the points 1-9 in the list are rendered as an HTML
> blockquote containing a list, causing them to be indented further than
> the rest of the list.
> 
> While at it, also fix the quotation marks around G and P.

Applied, thanks.

jon
