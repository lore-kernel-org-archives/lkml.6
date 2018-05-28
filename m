Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165830AbeE1OiT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:38:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:46790 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161336AbeE1OiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:38:15 -0400
Date: Mon, 28 May 2018 09:37:19 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/Makefile: fix build failure by disabling attribute-alias warning
Message-ID: <20180528143719.GB17342@gate.crashing.org>
References: <0adce33cf1c70ac7203f8ebd987a912451aabd45.1527517001.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0adce33cf1c70ac7203f8ebd987a912451aabd45.1527517001.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 02:17:49PM +0000, Christophe Leroy wrote:
> Latest GCC version emit many warnings similar to the following one.

You didn't actually show an example?

This warning should detect serious problems, so don't disable it without
first investigating please.

What do you call "latest version", btw?  Trunk, aka 9.0?  Or the most
advanced release, 8.1?  Or the latest release (which also is 8.1 :-) )


Segher
