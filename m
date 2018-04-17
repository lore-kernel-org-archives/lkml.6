Return-Path: <alexander.shishkin@linux.intel.com>
X-Google-Smtp-Source: AIpwx48vXmQl5prLs8Irnj7dXtPbrMcmf5c86ZtghvurDllzYnlAdZwueWRRkHw1qM3dJ1tgIoJT
ARC-Seal: i=1; a=rsa-sha256; t=1523959007; cv=none;
        d=google.com; s=arc-20160816;
        b=YMlGUFZ/iKmyCBX206QiKn/LjninFr91DSlvOVFb0fryzuaBcoekrU8qFZs4WEA07v
         V8rYijIM/eE0Q+JKROvLbxbWdSrmVGJQExGSy3YlEi3yA+Gb81ngx3tM5ZqMye6HLwrO
         gNXGDqpTGgtHtheqWT/HDlHRX2amqlSgVrL49unaEIDNCB2pGjC6RbWQstS6gQ7q2h1f
         roLdAnv796U9zRXt6ifHe959YYAR1CFXxXARnDFq5oWQPQ163zNS5Sf95njQ89jn9XUi
         M0rA+Tp5ar2IilSWRcRmDqsri7M5pcHRAuB6a2qgwbzKHhL3tXYx06ba5KsyN+OFLzQ9
         2y+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=T4VojYx9NjWYhYVmsT5YHMMg26FYrNULRhI1e24Lk/0=;
        b=Gu3NUJdhKUToblgxEsYqYXKnh01hX6cVh4jROmMdQ+tLrHwMekoXPEpB9VmLpzrkrD
         g7+aOP0FwgNwOKaKnE2kM6J2tnKFUvyjoKSPABJTARaljYR8e8+qO8kqhVmgn5mFxz4q
         50srQhKd5ArepZ/x6L8s+29QFwjACOOkL9cpeNoAcmsHUnwilDJt+qEl919zXfZrplum
         BEw/a7blveORsUoUxnaJEbO2qRpR3C29WEAiyKGJnBnx/HbFjuY/dxjotUIpDPN9fDKp
         VC/v64ZinD5heusMVnL4+JKis8JxcDGdWxoqW0sfqyE4phqWoDp4Jsddeb/86aTMe7ux
         jiLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of alexander.shishkin@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=alexander.shishkin@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of alexander.shishkin@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=alexander.shishkin@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,463,1517904000";
   d="scan'208";a="221053090"
Date: Tue, 17 Apr 2018 12:56:42 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
	leo.yan@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: Moving framework and drivers to SPDX
 identifier
Message-ID: <20180417095642.qrtf3gpotxxsikle@um.fi.intel.com>
Mail-Followup-To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
	leo.yan@linaro.org, linux-kernel@vger.kernel.org
References: <1523911862-29218-1-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523911862-29218-1-git-send-email-mathieu.poirier@linaro.org>
User-Agent: NeoMutt/20171215
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597937409545454672?=
X-GMAIL-MSGID: =?utf-8?q?1597986839748169769?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 02:51:02PM -0600, Mathieu Poirier wrote:
> Moving all kernel side CoreSight framework and drivers to SPDX identifier.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

This reminds me: there's drivers/hwtracing/stm/ftrace.c that I didn't
convert during the previous round, do you want to do it or should I?

Thanks,
--
Alex
