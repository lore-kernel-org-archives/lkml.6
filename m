Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86740C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442D6208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442D6208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeJPDI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:08:29 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:49954 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeJPDI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:08:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id BA4AE22556;
        Mon, 15 Oct 2018 19:21:51 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M8a9AREedb2u; Mon, 15 Oct 2018 19:21:51 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 9B3DA22559;
        Mon, 15 Oct 2018 19:21:43 +0000 (UTC)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>
From:   Shuah Khan <shuah@kernel.org>
Subject: [GIT PULL] cpupower update for Linux 4.20-rc1
Message-ID: <88f95364-29a8-358e-356e-e62771e52c8e@kernel.org>
Date:   Mon, 15 Oct 2018 13:21:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------E7C80CE968FD9FC61062210A"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E7C80CE968FD9FC61062210A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 4.20-rc1

This cpupower update for Linux 4.20-rc1 consists of fixes for bugs and
compile warnings from Prarit Bhargava and Anders Roxell.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-4.20-rc1

for you to fetch changes up to f69ffc5d3db8f1f03fd6d1df5930f9a1fbd787b6:

  cpupower: Fix coredump on VMWare (2018-10-08 09:19:15 -0600)

----------------------------------------------------------------
linux-cpupower-4.20-rc1

This cpupower update for Linux 4.20-rc1 consists of fixes for bugs and
compile warnings from Prarit Bhargava and Anders Roxell.

----------------------------------------------------------------
Anders Roxell (1):
      cpupower: remove stringop-truncation waring

Prarit Bhargava (2):
      cpupower: Fix AMD Family 0x17 msr_pstate size
      cpupower: Fix coredump on VMWare

 tools/power/cpupower/bench/parse.c        | 2 +-
 tools/power/cpupower/utils/cpufreq-info.c | 2 ++
 tools/power/cpupower/utils/helpers/amd.c  | 7 ++++++-
 3 files changed, 9 insertions(+), 2 deletions(-)
----------------------------------------------------------------

--------------E7C80CE968FD9FC61062210A
Content-Type: text/plain; charset=UTF-8;
 name="linux-cpupower-4.20-rc1.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="linux-cpupower-4.20-rc1.txt"

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA1YjM5NGIyZGRmMDM0N2JlZjU2
ZTUwYzY5YTU4NzczYzk0MzQzZmYzOgoKICBMaW51eCA0LjE5LXJjMSAoMjAxOC0wOC0yNiAx
NDoxMTo1OSAtMDcwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0
OgoKICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc2h1
YWgvbGludXggdGFncy9saW51eC1jcHVwb3dlci00LjIwLXJjMQoKZm9yIHlvdSB0byBmZXRj
aCBjaGFuZ2VzIHVwIHRvIGY2OWZmYzVkM2RiOGYxZjAzZmQ2ZDFkZjU5MzBmOWExZmJkNzg3
YjY6CgogIGNwdXBvd2VyOiBGaXggY29yZWR1bXAgb24gVk1XYXJlICgyMDE4LTEwLTA4IDA5
OjE5OjE1IC0wNjAwKQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpsaW51eC1jcHVwb3dlci00LjIwLXJjMQoKVGhp
cyBjcHVwb3dlciB1cGRhdGUgZm9yIExpbnV4IDQuMjAtcmMxIGNvbnNpc3RzIG9mIGZpeGVz
IGZvciBidWdzIGFuZApjb21waWxlIHdhcm5pbmdzIGZyb20gUHJhcml0IEJoYXJnYXZhIGFu
ZCBBbmRlcnMgUm94ZWxsLgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpBbmRlcnMgUm94ZWxsICgxKToKICAgICAg
Y3B1cG93ZXI6IHJlbW92ZSBzdHJpbmdvcC10cnVuY2F0aW9uIHdhcmluZwoKUHJhcml0IEJo
YXJnYXZhICgyKToKICAgICAgY3B1cG93ZXI6IEZpeCBBTUQgRmFtaWx5IDB4MTcgbXNyX3Bz
dGF0ZSBzaXplCiAgICAgIGNwdXBvd2VyOiBGaXggY29yZWR1bXAgb24gVk1XYXJlCgogdG9v
bHMvcG93ZXIvY3B1cG93ZXIvYmVuY2gvcGFyc2UuYyAgICAgICAgfCAyICstCiB0b29scy9w
b3dlci9jcHVwb3dlci91dGlscy9jcHVmcmVxLWluZm8uYyB8IDIgKysKIHRvb2xzL3Bvd2Vy
L2NwdXBvd2VyL3V0aWxzL2hlbHBlcnMvYW1kLmMgIHwgNyArKysrKystCiAzIGZpbGVzIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
--------------E7C80CE968FD9FC61062210A--
