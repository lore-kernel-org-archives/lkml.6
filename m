Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeEGH4K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:56:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36914 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeEGH4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:56:09 -0400
X-Google-Smtp-Source: AB8JxZpuP5FVW6SVyYh4YidZA7W3Cjwoqr/bgZR63BwdgiRPfe+EUyY2Asg+79Kc5gZsmP8pye3iPg==
Message-Id: <20180507075213.386076821@gmail.com>
User-Agent: quilt/0.65
Date: Mon, 07 May 2018 10:52:13 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Jonathan de Boyne Pollard
        <J.deBoynePollard-newsgroups@NTLWorld.COM>,
        Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [rfc linux-next 0/3] prctl: prctl_set_mm -- Bring back handling of PR_SET_MM_x
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! Yesterday I've been pointed out that we unfortunatelly can't
drop off PR_SET_MM_x operations. So here is a series which bring
them back but instead of plain revert I tried to simplify the
code and make it as minimum as possible.

WARN: the series is compile-tested only for a while, I wanted
to share it early so maybe someone has better idea of how
integrate old PR_SET_MM_x operations. I'll do full tests
today hopefully.

	Cyrill
