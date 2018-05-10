Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbeEJWgX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 18:36:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750711AbeEJWgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 18:36:21 -0400
Date: Thu, 10 May 2018 17:36:19 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: cross-compiling a 64-bit kernel on a 32-bit host
Message-ID: <20180510223619.jwdlle42brksfp4v@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fengguang,

I occasionally get compilation bug reports from people who are
cross-compiling an x86-64 kernel target on an x86-32 host.

Any chance the 0-day build bot could test that configuration?  I think
just building a defconfig would be sufficient.  It would help sort out
issues in objtool and other host-built scripts.

-- 
Josh
