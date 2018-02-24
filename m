Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AH8x224+6MRqf6co15DsExVTe82i238O0x4Q1eLXZTzMLmpg2pWLYMAjyyeXDQFtXSLIhpz4SFBy
ARC-Seal: i=1; a=rsa-sha256; t=1519440233; cv=none;
        d=google.com; s=arc-20160816;
        b=eAJJ68J0eO5EA+ZCNDeDRP3JNPNulCdQKiAf6iIQPs3FejyV1r0kPwKC6rhQThZ7Kf
         ZKqjxv7qrPdC22aFp1BYtOLgula1+DrwrSawejg5rWmxR8Y6Nw8nkLL1N0LJq3JhVwRK
         ihrJ5glqkEGS3NSdaOY5OAhEkWJGi3zAdOSNcEkjLaFqzEHp0VZJhsaaIg9sEjmoDtNB
         GkOvMtibEMcJegS034861ydE7CjaQL/0+9E92F/xx/5a56h2Tmi/jTLcCFxDEvaFsb8Q
         docJ6/D8FJzKWm000QgDK4dnJwh68lEkrUT6pSCIQ+o694grRyFQHTBguJ+nycEACjYn
         umhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=K99qk85I4DOUKoV30WGoTEukvCxGrkorKAuPXA3xf24=;
        b=HlVT1e6T1A7dwt3sK8hn8sP+T+VsZP/GoVIfvY1sHKKBCzyzPLLCnMJazcvGknjTeH
         S/QJ4QntaEVTB/sd5SMIelrBvQJtiAyUxxS+xFgHXHfs+eZAK/aOIRsiXwIxUUqqJN8k
         5y2UyraV45hGT4ttaOoYoG7Tp47gofZ7DfmG7s9YAkwYaY/zvNkki1BEJs2ue4oa3kRP
         Q6SjJO5mRTzhvF+oz8mxQfUt0QpRKY0AMfvn13qhYBNQXyWaCCAtxQuMyAokttASsse5
         Bg04kuT8ypGCHUhDomRJzUVs62Epsq1u8GezxrbJFZiPKT3b41BJPYtE2IMqjocUu4rr
         MtGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Sat, 24 Feb 2018 02:43:48 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	keescook@chromium.org, shuah@kernel.org, mfuzzey@parkeon.com,
	zohar@linux.vnet.ibm.com, dhowells@redhat.com, pali.rohar@gmail.com,
	tiwai@suse.de, arend.vanspriel@broadcom.com, zajec5@gmail.com,
	nbroeking@me.com, markivx@codeaurora.org, stephen.boyd@linaro.org,
	broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
	torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org, jewalt@lgsinnovations.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] firmware: cleanup for v4.17
Message-ID: <20180224024348.GA14069@wotan.suse.de>
References: <20180214004148.14452-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214004148.14452-1-mcgrof@kernel.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334920498977895?=
X-GMAIL-MSGID: =?utf-8?q?1593248562095240739?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 04:41:37PM -0800, Luis R. Rodriguez wrote:
> 0-day has given me its blessings on these builds.

Spoke too soon, 0-day found one build issue later once I used Linus' tree
instead of linux-next, and I found another one on my own. I've fixed these.
Since these patches are not merged yet I'll just roll in the fixes and post a
v2 series.

  Luis
