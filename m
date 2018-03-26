Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeCZOmU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:42:20 -0400
Received: from ms.lwn.net ([45.79.88.28]:54540 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752109AbeCZOmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:42:18 -0400
Date: Mon, 26 Mar 2018 08:42:17 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Martin Kepplinger <martink@posteo.de>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: magic-numbers: Fix typo
Message-ID: <20180326084217.34a19a55@lwn.net>
In-Reply-To: <20180323073231.5826-1-martink@posteo.de>
References: <20180323073231.5826-1-martink@posteo.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018 08:32:31 +0100
Martin Kepplinger <martink@posteo.de> wrote:

> This fixes a little then / them confusion.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
>  Documentation/process/magic-number.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/magic-number.rst b/Documentation/process/magic-number.rst
> index c74199f60c6c..00cecf1fcba9 100644
> --- a/Documentation/process/magic-number.rst
> +++ b/Documentation/process/magic-number.rst
> @@ -14,7 +14,7 @@ passing pointers to structures via a void * pointer.  The tty code,
>  for example, does this frequently to pass driver-specific and line
>  discipline-specific structures back and forth.
>  
> -The way to use magic numbers is to declare then at the beginning of
> +The way to use magic numbers is to declare them at the beginning of
>  the structure, like so::
>  
>  	struct tty_ldisc {

Applied, thanks.

jon
