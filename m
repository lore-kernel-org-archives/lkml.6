Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FB4C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDE820657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="n9wRGtHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDE820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeKBIBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:01:23 -0400
Received: from mail.efficios.com ([167.114.142.138]:57954 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeKBIBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:01:23 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 47974248852;
        Thu,  1 Nov 2018 18:56:23 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 44S2WnqgHC-I; Thu,  1 Nov 2018 18:56:22 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BA7C324884C;
        Thu,  1 Nov 2018 18:56:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BA7C324884C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1541112982;
        bh=n8Ln8ZlirRwdCDVBPg1jEz2Sp5nvtI7aLPMCPCg3byA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=n9wRGtHlbFwiLd8xwcbElHa0dwBSfjCBqdlRuqsqmYxSKIBqJk8Xx4nY23U5a3CMq
         LM1wYGkUH84wgaK2Xlk1igP3r/F9ibGlwto3z/l8Cc1tPh4XO7NPGF9+M20iKRhKNT
         8dQjRJ3lEYsinPjJXVI//+RNXSncso2inCxdNnoHauMoxFs/xFJwfFIgL4ueSnb8Jl
         YI8579WkfyNqYIGWyo0RpnCSCKephLM8dY1r2jga8sC/XRxSYEWJUMM2hzXvQlzec4
         rvS+wlWT7HLJWohwFQjVN+odnr1+Oosr/cjkCN0NkCdR3iI6UC5YV+frlJW6BB8q/t
         DPZXU8qPGthgA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id EWqfS-ZwWS29; Thu,  1 Nov 2018 18:56:22 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id A5EC0248845;
        Thu,  1 Nov 2018 18:56:22 -0400 (EDT)
Date:   Thu, 1 Nov 2018 18:56:22 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <60988959.4070.1541112982406.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.9.11, 2.10.8, 2.11.0-rc2 (Linux kernel
 tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3039 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Index: tPGqQ4bYAUy0C7xvjszzymSLkfukHg==
Thread-Topic: LTTng-modules 2.9.11, 2.10.8, 2.11.0-rc2 (Linux kernel tracer)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a set of bugfix releases of the LTTng modules kernel tracer.
It covers the three currently active lttng-modules branches: the
2.9 and 2.10 stable branches, as well as the 2.11 branch in release
candidate cycle.

Those releases add support for kernel 4.19.

One important improvement is to prevent allocation of buffers larger
than the available memory, which can cause the OOM killer to trigger.
Even if the OOM killer end up having to trigger, the current OOM kill
target is set to the current thread while allocating buffers.

Enjoy!

Mathieu

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:

2018-11-01 (National Men Make Dinner Day) LTTng modules 2.11.0-rc2
        * Fix: update kvm instrumentation for SLES12 SP2 LTSS >= 4.4.121-92.92
        * Fix: Add missing const to lttng_tracepoint_ptr_deref prototype
        * Fix: adapt to kernel relative references
        * Fix: implicit declarations caused by buffer size checks.
        * Prevent allocation of buffers if exceeding available memory
        * Fix: btrfs instrumentation namespacing
        * Fix: Convert rcu tracepointis to gp_seq (v4.19)
        * Fix: tracing: Centralize preemptirq tracepoints (4.19)
        * Fix: net: expose sk wmem in sock_exceed_buf_limit tracepoint (4.19)
        * Fix: access migrate_disable field directly
        * Fix: out of memory error handling

2018-11-01 (National Men Make Dinner Day) LTTng modules 2.10.8
        * Fix: update kvm instrumentation for SLES12 SP2 LTSS >= 4.4.121-92.92
        * Fix: Add missing const to lttng_tracepoint_ptr_deref prototype
        * Fix: adapt to kernel relative references
        * Fix: implicit declarations caused by buffer size checks.
        * Prevent allocation of buffers if exceeding available memory
        * Fix: Convert rcu tracepointis to gp_seq (v4.19)
        * Fix: net: expose sk wmem in sock_exceed_buf_limit tracepoint (4.19)
        * Fix: access migrate_disable field directly
        * Fix: out of memory error handling

2018-11-01 (National Men Make Dinner Day) LTTng modules 2.9.11
        * Fix: update kvm instrumentation for SLES12 SP2 LTSS >= 4.4.121-92.92
        * Fix: Add missing const to lttng_tracepoint_ptr_deref prototype
        * Fix: adapt to kernel relative references
        * Fix: implicit declarations caused by buffer size checks.
        * Prevent allocation of buffers if exceeding available memory
        * Fix: Convert rcu tracepointis to gp_seq (v4.19)
        * Fix: net: expose sk wmem in sock_exceed_buf_limit tracepoint (4.19)
        * Fix: access migrate_disable field directly
        * Fix: out of memory error handling


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
