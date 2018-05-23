Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933682AbeEWQo1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:44:27 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34352 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933596AbeEWQoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:44:25 -0400
X-Google-Smtp-Source: AB8JxZr2JmH8l2mlh4VWP8yLZ1pWnMOhiUP5Pa477byL6YkilQ9RiSd1j/h0ZOJb+f0Kq9GPzK+meg==
Date: Wed, 23 May 2018 11:44:23 -0500
From: Rob Herring <robh@kernel.org>
To: frowand.list@gmail.com
Cc: pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: overlay: validate offset from property fixups
Message-ID: <20180523164423.GA29515@rob-hp-laptop>
References: <1526530791-18591-1-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526530791-18591-1-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 09:19:51PM -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The smatch static checker marks the data in offset as untrusted,
> leading it to warn:
> 
>   drivers/of/resolver.c:125 update_usages_of_a_phandle_reference()
>   error: buffer underflow 'prop->value' 's32min-s32max'
> 
> Add check to verify that offset is within the property data.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/resolver.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

Rob
