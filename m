Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756105AbeDZMhT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:37:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:33753 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755866AbeDZMhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:37:15 -0400
Date: Thu, 26 Apr 2018 14:37:12 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
cc: srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] hid: intel-ish-hid: use put_device() instead of
 kfree()
In-Reply-To: <66bd5f1ab1322081927f657090a04b44da326140.1522408033.git.arvind.yadav.cs@gmail.com>
Message-ID: <nycvar.YFH.7.76.1804261437040.28147@cbobk.fhfr.pm>
References: <66bd5f1ab1322081927f657090a04b44da326140.1522408033.git.arvind.yadav.cs@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018, Arvind Yadav wrote:

> Never directly free @dev after calling device_register(), even
> if it returned an error. Always use put_device() to give up the
> reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs
