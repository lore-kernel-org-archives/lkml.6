Return-Path: <jani.nikula@intel.com>
X-Google-Smtp-Source: AB8JxZp7+MwxGJ6JE3UJNIYoXY+IbEWSkrpbcvc2eiKON6s4J7kRBQAeDVNHm6NKYf68e4fbDBiA
ARC-Seal: i=1; a=rsa-sha256; t=1525345573; cv=none;
        d=google.com; s=arc-20160816;
        b=0avoy31mTJH3Xkbq36eKqnE9uDUZGziRvq3BrJ5xWJLbUTv88d7FjtXZlBqV7d/dth
         dZpYyLpSdQFZ5JKKEVoZFE241xLUUwKAgEOwgJFtlNKb6tggEndnNuDEo94BcNxgnaZM
         +bLuWvcuUmK/d37hP6Qr2ubE6zDaC7CtlwlpyDKdEQzz9SMjvuDIfSDhjtDjRQ5o2OFj
         3Rhste47SxZF9A3JDmvA+6QG92Gak9wdcjB9tKnPQDl62tpXGtJI94KDVugo+sCAyAvZ
         51fVwf/xJxZ12VEkSvNR7QbZjWZC6YXpivUCTMzzfwlaeSUt5T8nWPhvVnuh9ckxJtwW
         f7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:organization:in-reply-to
         :subject:cc:to:from:arc-authentication-results;
        bh=IyHIf+wA/HV236eHr5xGG6OpAFEiJHp0UjpC/+lYGU0=;
        b=DiOKtrCGuSjjN1pMONYzsP55plBKbaZXyaT8INW0TayOP/hQJwr7RW1AMrXNAQYEJU
         GH8AFSwIaRbsp80LqJAZq9rufIoS2Q2zklWqzTY9qIZJRUQTDVF6M++ZMnsRreVDibOM
         hdiZwsGDS5QgV7wSSErCBWtHKTiDWpyTLOkx1IpXh6h8cGTnzvVAnK79IYgw9uJxenxQ
         NeB3sMdUSHiikHIPqJb9bnJ3KDr26ZvHKPLIZmVGidfIfCL+nVwgz5g1qnziw3MaN0WD
         kljA8Dfez068Ss4m+Dy7RdGCypQmm3g+SU5xxiKZlkBSiFqdEnuNXVT4nQgGPWvkXg6P
         RZnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jani.nikula@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jani.nikula@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jani.nikula@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jani.nikula@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="52065816"
From: Jani Nikula <jani.nikula@intel.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>, "w\@1wt.eu" <w@1wt.eu>, "ksummit-discuss\@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
In-Reply-To: <20180501205448.GE10479@thunk.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180501163818.GD1468@sasha-vm> <20180501194450.GD10479@thunk.org> <20180501200019.GA7397@sasha-vm> <20180501205448.GE10479@thunk.org>
Date: Thu, 03 May 2018 14:08:51 +0300
Message-ID: <877eol808s.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599440759627495902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 01 May 2018, "Theodore Y. Ts'o" <tytso@mit.edu> wrote:
> Post -rc3 or -rc4, in my opinion bug fixes should wait until the next
> merge window before they get merged at all.

What are -rc5 and later for then if not bug fixes? Baffled.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Technology Center
