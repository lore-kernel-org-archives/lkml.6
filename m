Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753700AbeEOQkj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:40:39 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43248 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeEOQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:40:37 -0400
X-Google-Smtp-Source: AB8JxZqAod1nM57UNXlxTrw72xUebxWlBptyg8sEOxC9UAfJ939zoa5rIl+5T6yC9Ke5WfIXwruxAw==
Date: Tue, 15 May 2018 09:40:34 -0700
From: Tejun Heo <tj@kernel.org>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: cgroup/memcontrol: add basic test for swap
 controls
Message-ID: <20180515164034.GF2368884@devbig577.frc2.facebook.com>
References: <1526400353-12991-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526400353-12991-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 07:05:53PM +0300, Mike Rapoport wrote:
> The new test verifies that memory.swap.max and memory.swap.current behave
> as expected for simple allocation scenarios
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Looks good to me.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
