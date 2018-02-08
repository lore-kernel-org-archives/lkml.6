Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeBHT6E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:58:04 -0500
Received: from ms.lwn.net ([45.79.88.28]:55636 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeBHT6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:58:03 -0500
Date: Thu, 8 Feb 2018 12:58:00 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
Subject: Re: [PATCH 7/8] docs: kernel-doc: Finish moving STATE_* code out of
 process_file()
Message-ID: <20180208125800.3dae9456@lwn.net>
In-Reply-To: <20180208022953.GB3304@eros>
References: <20180207172624.24555-1-corbet@lwn.net>
        <20180207172624.24555-8-corbet@lwn.net>
        <20180208022953.GB3304@eros>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2018 13:29:53 +1100
"Tobin C. Harding" <me@tobin.cc> wrote:

> It doesn't appear to be introduced by you but the brace positions are
> non-uniform in this patch.
> 
> if
> {
>   ...
> }
> else
> {
>   ...
> }
> 
> instead of
> 
> if {
>   ...
> } else {
>   eee
> }

True, that's worth fixing up while I'm in the neighborhood.  I'll do that
before I commit the set.

Thanks,

jon
