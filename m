Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965856AbeBMVNf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 16:13:35 -0500
Received: from ms.lwn.net ([45.79.88.28]:49694 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965795AbeBMVNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 16:13:34 -0500
Date: Tue, 13 Feb 2018 14:13:31 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Xiongwei Song <sxwjean@me.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        sxwjean@gmail.com
Subject: Re: [PATCH] tracing: Fix incorrect file name
Message-ID: <20180213141331.50906661@lwn.net>
In-Reply-To: <20180204101424.9562-1-sxwjean@me.com>
References: <20180204101424.9562-1-sxwjean@me.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Feb 2018 18:14:24 +0800
Xiongwei Song <sxwjean@me.com> wrote:

> There is no file named 'enabled' in the directory tracing/events. It should
> be the file 'enable'.

Makes sense, applied to the docs tree, thanks.

jon
