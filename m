Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161950AbeBNS1U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:27:20 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:48638 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161778AbeBNS1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:27:17 -0500
Date: Wed, 14 Feb 2018 19:27:16 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/entry/64: use xorl for register clearing
Message-ID: <20180214182716.GA5918@isilmar-4.linta.de>
References: <20180214182112.GA29859@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214182112.GA29859@avx2>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 09:21:12PM +0300, Alexey Dobriyan wrote:
> > -	xorq    %r8, %r8	/* nospec   r8 */
> > +	xorl	%r8d, %r8d	/* nospec   r8 */
> 
> The suffix should be simply dropped as operand size is unambigious.
> It is just one more character than necessary on the screen.

No strong feelings about this issue, but I prefer it to be explicit. And
that's what seems to be the standard in arch/x86/entry/ .

Thanks,
	Dominik
