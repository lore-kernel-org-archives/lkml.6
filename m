Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbeC1Pq2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:46:28 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42460 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753816AbeC1Pq1 (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:46:27 -0400
X-Google-Smtp-Source: AIpwx49/jmt8ZdHWA6PHg996mpsAnII9S/Zyx/c6s+YPH09OkXH9TESNTkyPQFM+SMQtw68aRHTqxg==
Date: Wed, 28 Mar 2018 17:46:22 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH v2 4/4] perf: Support perf -vv
Message-ID: <20180328154622.65ate24g7be2xg3a@gmail.com>
References: <1522249028-15099-1-git-send-email-yao.jin@linux.intel.com>
 <1522249028-15099-5-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522249028-15099-5-git-send-email-yao.jin@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jin Yao <yao.jin@linux.intel.com> wrote:

> $ ./perf -vv or ./perf -version --build-options
> perf version 4.13.rc5.gcb1183

My suggestion was to add the 'version' subcommand like Git has, not a "-version" 
option:

  $ git version
  git version 2.14.1

Thanks,

	Ingo
