Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755670AbeDKU42 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 16:56:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42626 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755287AbeDKU40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 16:56:26 -0400
Date: Wed, 11 Apr 2018 13:56:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: fixup =?ISO-8859-1?Q?=A9?= sign
Message-Id: <20180411135624.480308a8d3875307853a1b09@linux-foundation.org>
In-Reply-To: <20180411201950.GA12904@avx2>
References: <20180411201950.GA12904@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018 23:19:50 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Andrew's scripts butchered it :-(

It's actually heirloom-mailx doing this.  I thought I'd avoided that by
using sylpheed by hand, but sylpheed selectively butchers it as well. More
whacking needed.

> Add copyright in two files before they get autorubberstamped.

checkpatch wants SPDX-License-Identifier in the new files, btw.
