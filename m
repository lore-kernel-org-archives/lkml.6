Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeBWPGz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:06:55 -0500
Received: from ms.lwn.net ([45.79.88.28]:57244 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751766AbeBWPG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:06:27 -0500
Date: Fri, 23 Feb 2018 08:06:26 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc-guide: kernel-doc: add comment about formatting
 verification
Message-ID: <20180223080626.54c053df@lwn.net>
In-Reply-To: <1519151785-25997-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1519151785-25997-1-git-send-email-rppt@linux.vnet.ibm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018 20:36:25 +0200
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> Currently there is no automated checking for kernel-doc comments except
> running 'kernel-doc -v -none <filename>'. Mention the possibility to run
> kernel-doc to verify formatting of the comments in the kernel-doc guide.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Applied, thanks.

jon
