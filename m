Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AIpwx49P/CuFETM0RIBLNl67x4Ph8/8No0PnSYIxiRfsfHPQuD3oLNbYm7Bc7+vVE+8TsjR7Iwch
ARC-Seal: i=1; a=rsa-sha256; t=1522980153; cv=none;
        d=google.com; s=arc-20160816;
        b=l5osEQNsndWhVvbgalCa3Ylw+HvJhWNEevIs7euyziIQhrdeVy1YUMADpkRVTJcOjO
         Pln8eFWbB5iTdeWA4u1RvHB1LfuNtaDAVtIJQvRQ/ETxtI92db8mx04xOYlgUHPI4uyU
         NaNUKXkud2AhWMA8Mr7Mg4bJyRdolLNFLhnLGQ4/xzeyRXmQanwB+ofxuD8ri0hIGGyJ
         FHrrDe0joddOJZeScu3pUjmklAxPSbDmldXQBupK5q5EFm/xiXoCdPaMXzH5m1lVkCgf
         ySxc3lp3DfN9Chh7akaAJZfhPl3WpWbTfukbv97tuArreSLw2LMKmRQeSEzvgeorqPV2
         PbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=7vt6Bh55aMRVKdIVi6ZubOk0GDsBnxy/ppA7iFu++r0=;
        b=MYcdOD2CLqSBJp++T0SaXCqVyjMMMLBm4QjSDoHBOpZnPKgHqayWMvjpB1i7MQhXTn
         gUZ50EWfEjYYoC2xHGboX7YjDglXxIMgt+0vdTRCgzqe8Ohb1PP+D3vWCbPe9upOL5iU
         x3xnUUyTILxVJ2NnqmpYUkJbL6K7ccdUNehAQALJ6q3Gz4a6eYbB7gihsO7f4alRnFc7
         eqzkrR5g9++R5QuIghFKnxGP3/aQcBmtESPTJNfbK2JFFkeEXfVS+aQPq4Xt+JX6U66W
         zG6knUMCoEpGaHCVrRv1uDhHM+omBWTjSMTL9GZXtlCmeSZXpUQKKnQr5Otb4QVRHRh7
         wIyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Thu, 05 Apr 2018 22:02:29 -0400 (EDT)
Message-Id: <20180405.220229.527506925753008237.davem@davemloft.net>
To: christian.brauner@canonical.com
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 avagin@virtuozzo.com, ktkhai@virtuozzo.com, serge@hallyn.com
Subject: Re: [PATCH net] netns: filter uevents correctly
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAPP7u0VQc33MiYP8Ene6K1Bqkx4LtBtQ0ugFYp_36UsxuusT1g@mail.gmail.com>
References: <20180404203048.GA21118@gmail.com>
	<871sfuha2d.fsf@xmission.com>
	<CAPP7u0VQc33MiYP8Ene6K1Bqkx4LtBtQ0ugFYp_36UsxuusT1g@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1596960437250908562?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christian Brauner <christian.brauner@canonical.com>
Date: Thu, 05 Apr 2018 01:27:16 +0000

> David, is it ok to queue this or would you prefer I resend when net-next
> reopens?

This definitely needs more discussion, and after the discussion some
further clarification in the commit log message based upon that
discussion if we move forward with this change at all.

Thank you.
