Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161791AbeBNSVS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:21:18 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:32816 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161673AbeBNSVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:21:16 -0500
X-Google-Smtp-Source: AH8x225hXhiaA2i2Bf4o+pYYl2VKnopA7caJ/KXw2A5MoQm80yD+9TGLLo6GFmh5yjr5URHRMHhhMg==
Date: Wed, 14 Feb 2018 21:21:12 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux@dominikbrodowski.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/entry/64: use xorl for register clearing
Message-ID: <20180214182112.GA29859@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -	xorq    %r8, %r8	/* nospec   r8 */
> +	xorl	%r8d, %r8d	/* nospec   r8 */

The suffix should be simply dropped as operand size is unambigious.
It is just one more character than necessary on the screen.
