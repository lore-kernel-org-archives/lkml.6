Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753729AbeDPUEF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 16:04:05 -0400
Received: from ms.lwn.net ([45.79.88.28]:58688 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753425AbeDPUEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 16:04:04 -0400
Date: Mon, 16 Apr 2018 14:04:02 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/process: updates to the PGP guide
Message-ID: <20180416140402.57442271@lwn.net>
In-Reply-To: <20180412204410.GA6909@work>
References: <20180412204410.GA6909@work>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2018 16:44:10 -0400
Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:

> Small tweaks to the Maintainer PGP guide:
> 
>  - Use --quick-addkey command that is compatible between GnuPG-2.2 and
>    GnuPG-2.1 (which many people still have)
>  - Add a note about the Nitrokey program
>  - Warn that some devices can't change the passphrase before there are
>    keys on the card (specifically, Nitrokeys)
>  - Link to the GnuPG wiki page about gpg-agent forwarding over ssh
>  - Tell git to use gpgv2 instead of legacy gpgv when verifying signed
>    tags or commits

Applied, thanks.

jon
