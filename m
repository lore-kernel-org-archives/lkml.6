Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754963AbeD3REx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 13:04:53 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:50988 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbeD3REv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 13:04:51 -0400
X-Google-Smtp-Source: AB8JxZqLbMhD0HzHtcNQyAfKAIvOaijZNs/TVVwq279y1L8bOWhgbbDEhj8hqaqaOnPMhHR3c5guFg==
Date: Mon, 30 Apr 2018 18:04:28 +0100 (IST)
From: John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To: Linux RT Users <linux-rt-users@vger.kernel.org>
cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        Marcelo <mtosatti@redhat.com>
Subject: [ANNOUNCE]rt-tests-1.3  New Devlopment version of rt-tests
Message-ID: <alpine.LFD.2.21.1804301747410.19103@planxty>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There is a new development version of rt-tests (cyclictest and friends)

As this is the unstable version, there might be some rough spots, but 
patches are welcome!

Recent development includes
- Clark Williams added python3 support for hwlatdetect
 Note: I will accept patches that make the code run correctly for 
both python3 and python2, but only if it doesn't break python3
- Marcelo Tosatti added a new test called queuelat
 Note: Please cc Marcelo on any questions / patches, etc to do with 
queuelat

Clone
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch
unstable/devel/latest

Tar ball
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/snapshot/rt-tests-1.3.tar.gz

Enjoy!

John Kacur
