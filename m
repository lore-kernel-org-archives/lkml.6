Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeCZOMR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:12:17 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:45152 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeCZOMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:12:15 -0400
X-Google-Smtp-Source: AG47ELscW4a6k8KmNqyIvG+MTmWu43BGUdYtkujPIY7hItiKaDoCwV8VsRpjwsnwvS5ruJ4snOlTGw==
Date: Mon, 26 Mar 2018 07:12:12 -0700
From: Tejun Heo <tj@kernel.org>
To: yuankuiz@codeaurora.org
Cc: cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, pkondeti@codeaurora.org,
        cgroups-owner@vger.kernel.org
Subject: Re: [PATCH]cgroup: __cpuset_node_allowed return bool
Message-ID: <20180326141212.GI2149215@devbig577.frc2.facebook.com>
References: <d2f9fe6096235032f445ab88e562560f@codeaurora.org>
 <0fee75e4a1b12f5fca30e04306a95788@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fee75e4a1b12f5fca30e04306a95788@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, John.

On Sat, Mar 24, 2018 at 01:05:50PM +0800, yuankuiz@codeaurora.org wrote:
> From 304cec1cc42255fbd9e231a810f4eea20ab74b90 Mon Sep 17 00:00:00 2001
> From: John Zhao <yuankuiz@codeaurora.org>
> Date: Sat, 24 Mar 2018 13:01:32 +0800
> Subject: [PATCH] cgroup: __cpuset_node_allowed return bool
> 
> as a bool, __cpuset_node_allowed(...) return should be bool.

So, as a minor cleanup patch, this is fine but can you please soften
the commit title / description a bit?  It doesn't have to be bool.
int is fine.  bool may be marginally more readable but that's about
it, so let's please make the commit match that.

Thanks.

-- 
tejun
