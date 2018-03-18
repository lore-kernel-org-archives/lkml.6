Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754615AbeCRWoe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:44:34 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33032 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754258AbeCRWo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:44:29 -0400
X-Google-Smtp-Source: AG47ELtMkF4S6zk5SzjFXYk0jJq/3mDxept8yKsLHNtNJXXXn1vFCjBOaGmQyzsyg1djNl5ZjgVbAA==
Date: Sun, 18 Mar 2018 15:44:31 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/3] remoteproc: imx_rproc: Improve 'imx_rproc_probe()'
Message-ID: <20180318224431.GB5626@tuxbook-pro>
References: <cover.1521057013.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1521057013.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Mar 12:56 PDT 2018, Christophe JAILLET wrote:

> Patch 1 fixes a bug.
> Patches 2 and 3 are just clean-ups.
> 

All three patches applied.

Thanks,
Bjorn

> Christophe JAILLET (3):
>   remoteproc: imx_rproc: Fix an error handling path in
>     'imx_rproc_probe()'
>   remoteproc: imx_rproc: Re-use existing error handling path in
>     'imx_rproc_probe()'
>   remoteproc: imx_rproc: Slightly simplify code in 'imx_rproc_probe()'
> 
>  drivers/remoteproc/imx_rproc.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> -- 
> 2.14.1
> 
