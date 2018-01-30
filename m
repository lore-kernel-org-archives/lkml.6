Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753184AbeA3Uu5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:50:57 -0500
Received: from home.regit.org ([37.187.126.138]:37260 "EHLO home.regit.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbeA3Uu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:50:56 -0500
From: Eric Leblond <eric@regit.org>
To: daniel@iogearbox.net
Cc: alexei.starovoitov@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v8 0/5] libbpf: add XDP binding support
Date: Tue, 30 Jan 2018 21:50:37 +0100
Message-Id: <20180130205042.19647-1-eric@regit.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <a26f90e9-5028-f8a9-a1e6-83a6c46b4e0b@iogearbox.net>
References: <a26f90e9-5028-f8a9-a1e6-83a6c46b4e0b@iogearbox.net>
X-Spam-Score: -1.0 (-)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Daniel,

No problem with the delay in the answer. I'm doing far worse.

Here is an updated version:
- add if_link.h in uapi and remove the definition
- fix a commit message
- remove uapi from a include

Best Regards,
--
Eric
