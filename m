Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750848AbeEaXN5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 19:13:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53106 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEaXN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 19:13:56 -0400
Date: Fri, 1 Jun 2018 00:13:55 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/32] VFS: Introduce the basic header for the new mount
 API's filesystem context [ver #8]
Message-ID: <20180531231354.GM30522@ZenIV.linux.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720674345.9073.7664682296580266598.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152720674345.9073.7664682296580266598.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 01:05:43AM +0100, David Howells wrote:
> +	void			*fs_private;	/* The filesystem's context */
	...
> +	void			*s_fs_info;	/* Proposed s_fs_info */

While we are at it, do we really need both in generic interface?
