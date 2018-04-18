Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeDRXco (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 19:32:44 -0400
Received: from [195.159.176.226] ([195.159.176.226]:40573 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1753056AbeDRXcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 19:32:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Akemi Yagi <toracat@elrepo.org>
Subject: Re: Linux 4.9.94
Date: Wed, 18 Apr 2018 23:30:22 +0000 (UTC)
Message-ID: <pb8kee$ofo$1@blaine.gmane.org>
References: <20180413202359.GA22934@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Pan/0.135 (Tomorrow I'll Wake Up and Scald Myself with Tea; GIT
        30dc37b master)
Cc: stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This release has the same build failure on file tools/perf/tests/code-
reading.c as the one reported for 4.4.128:

Quoting from https://lkml.org/lkml/2018/4/16/246

tests/code-reading.c: In function ‘read_object_code’:
tests/code-reading.c:186:19: error: ‘KMOD_DECOMP_LEN’ undeclared
(first use in this function)
  char decomp_name[KMOD_DECOMP_LEN];

The issue on 4.4.128 posted here:

https://lkml.org/lkml/2018/4/14/17

Thanks,
Akemi
