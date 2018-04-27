Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933020AbeD0XRP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 19:17:15 -0400
Received: from ms.lwn.net ([45.79.88.28]:55440 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932342AbeD0XRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 19:17:14 -0400
Date: Fri, 27 Apr 2018 17:17:12 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] documentation: core-api: rearrange a few kernel-api
 chapters and sections
Message-ID: <20180427171712.4e09233a@lwn.net>
In-Reply-To: <f05c8785-e9e1-0a5e-b362-50669b75d80b@infradead.org>
References: <f05c8785-e9e1-0a5e-b362-50669b75d80b@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2018 18:11:02 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

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

The changes look good.  But ... grr... some of the stuff you are moving
around was introduced in -rc2 via the networking tree.  That kind of thing
makes life harder than it needs to be.  I've sorted it out and applied the
patch, thanks.

jon
