Return-Path: <acme@kernel.org>
X-Google-Smtp-Source: AIpwx4/0xVUjsadWxblUenzUIY+Bv8qO6nxYI+ol15zq5X+ZebsD0e5A3oDJtiIQfDNlsUNC7a4d
ARC-Seal: i=1; a=rsa-sha256; t=1524151908; cv=none;
        d=google.com; s=arc-20160816;
        b=ThanNgMYJgUD/5MyYXCCg/Rwr2r+Lnz82wU0T5RAdKQ0jzYcs0oc16GFuIOGN88gNR
         yd8zbwAIJ39/ePQziRRlkBaOoR5TztKUmKhhPUu5Z+3PKtJpvfVbX6TJGc/RtzXDR3dr
         GWvrhofMKQu1vEFJi89QQd1C+2vsGwR6MWIvPrZek/yL/YEMRF5tWPoaAijX+8A8kiOF
         r5Kjnv407znswPlhGjn+IP6/MkWsngwQMcOw/evLDGDu4Kip34tfE0E7rUNWRU1mZ5MM
         mLm1KH9wsOrKvjXuyz5tbzI09VymwikVcIQN+6Qf4L+7StFZueCCqtJRtJ/Fi18kiujM
         xylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=WRE9mFAVZoqSL7EgrOmhRKVKuB8isqW1Zebw1Wi85Rk=;
        b=RkC6jjtUx8PZjf7mhKG2ecE7zB/xyho5B2n+WrZMo3JvNTfvFccv9cWNNXH9muRQQl
         3EhXavGH5U/62PYZmHQ0nvtf6uqu2CBcmWyarMQij+nJLYccEgMFMZ6Hf+EzRmXGROQj
         rnnlRNG20ddVmYmI87fBrRgssZX267ZSIXfBFThQXlYKB7lO065GQjkkT/Epa9FbW7vd
         UEVuNq4SaWqAzbE2dTcJRRwkDlkxsFh3yZTluZrbp5S1aPvjm+G9gbyzhHfJXHGQyswS
         mJocoFVjKo98vpL9oVfCnqeX6CWBj7ZNZubJWFUWjcdb4aE3d6fb2jFELwD48w+h02aw
         r1BQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of acme@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=acme@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of acme@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=acme@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833892177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 19 Apr 2018 12:31:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: peterz@infradead.org, mingo@redhat.com, jolsa@redhat.com,
	alexander.shishkin@linux.intel.com, namhyung@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf tools: coresight: Moving to SPDX identifier
Message-ID: <20180419153145.GD22762@kernel.org>
References: <1524089118-27595-1-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524089118-27595-1-git-send-email-mathieu.poirier@linaro.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598123276333048680?=
X-GMAIL-MSGID: =?utf-8?q?1598189111305114608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Wed, Apr 18, 2018 at 04:05:18PM -0600, Mathieu Poirier escreveu:
> Moving perf tools CoreSight support to the SPDX identifier.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks, applied.

- Arnaldo
