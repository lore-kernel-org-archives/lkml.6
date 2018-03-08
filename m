Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755973AbeCHObn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:31:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:56445 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755544AbeCHObm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:31:42 -0500
Subject: Re: [PATCH] xen: xenbus: use put_device() instead of kfree()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, boris.ostrovsky@oracle.com
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
References: <46ec1b05b5643fd6c52ada8c6d8e4a9f1c3f1da8.1520330916.git.arvind.yadav.cs@gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <bd2e633a-b0cc-c79a-2563-aa541a224184@suse.com>
Date: Thu, 8 Mar 2018 15:31:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <46ec1b05b5643fd6c52ada8c6d8e4a9f1c3f1da8.1520330916.git.arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/18 11:10, Arvind Yadav wrote:
> Never directly free @dev after calling device_register(), even
> if it returned an error! Always use put_device() to give up the
> reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Committed to xen/tip.git for-linus-4.16a


Juergen
