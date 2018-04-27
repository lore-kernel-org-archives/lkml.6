Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758324AbeD0NVT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:21:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758117AbeD0NVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:21:17 -0400
Date: Fri, 27 Apr 2018 06:21:16 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] documentation: core-api: rearrange a few kernel-api
 chapters and sections
Message-ID: <20180427132116.GC8161@bombadil.infradead.org>
References: <f05c8785-e9e1-0a5e-b362-50669b75d80b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f05c8785-e9e1-0a5e-b362-50669b75d80b@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 06:11:02PM -0700, Randy Dunlap wrote:
> Rearrange some kernel-api chapters and sections to group them
> together better.
> 
> - move Bit Operations from Basic C Library Functions to Basic
>   Kernel Library Functions (now adjacent to Bitmap Operations since
>   they are not typical C library functions)
> 
> - move Sorting from Math Functions to Basic Kernel Library Functions
>   since sort functions are more Basic than Math Functions
> 
> - move Text Searching from Math Functions to Basic Kernel Library
>   Functions (keep Sorting and Searching close to each other)
> 
> - combine CRC and Math functions together into the (newly named)
>   CRC and Math Functions chapter
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

This all makes sense to me.

Acked-by: Matthew Wilcox <mawilcox@microsoft.com>
