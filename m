Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AB8JxZpbfk8GpvJlDMjz0L8UG9QClIt1N8h8eI4HaSYRbjvWudBWTZ5/XITuGUw46O8qbBaHmh3w
ARC-Seal: i=1; a=rsa-sha256; t=1524254820; cv=none;
        d=google.com; s=arc-20160816;
        b=D6L5hk3PNjxby+EMQPmlA7fNiAZsQuhJvfQNbWMcsYRdUVeOJiEh7eJqkxwatuI1tM
         TbixgUPYU5OkGXblKn8R4zuausytfOKJC81VgYyhxygZWvWjAFGvTSZuPys2R0dmRTVl
         HpO6Z0utu/zQ2oxWYWj/9vY0/kZY7JwXv3OH7//FMxPpb7QA5v+Iz1Ps+1mDRuDzF6QT
         5dt9Pk5FDpzeTWW1Z0FmXdmG8d7fjUvkpcGEv82QFhlGqRYMdLpqyiS2Mh15HXfDZDaM
         Arzc4rtXZy46hye0V2iT9asJWZce8faXSCYarmt9go3IgXB4i6XR87WI92F4kSUriDOP
         bhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=aeqhniGPP9FjaJa8dgphr7NIeApnf3KC6erhiN0ncyQ=;
        b=edzNRBdDLR1EqzlEQhm+TNLechMY6nq/InEIxapYsm6xus8FfZRCvMwgbfzfe5dTYn
         zX3d4Ha8GhUCukzYRHPLuBMqF04oBSNKvI9c/rUUP83wUo7pf+hJz1TqASXUE0RmlFa4
         uL6W4NfuSvYahHozXz689t3fnJJxanJo8QQr2aQaUEJGkSaPipFXywLdqWTd53Z/aQBM
         Puej+n2Cgb+8E99WXpZ7qIqjFgKS0QhydSNxgUGd6NnHW+auqR76Yg462PrkjEys4RJG
         ARDM2kPmvASVOz3Ux5oPkK08zeJ68apXWc5RCtu1YkVcWH3LpNytlDGvJGzu3g6n1Rb7
         dd6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Fri, 20 Apr 2018 16:06:53 -0400 (EDT)
Message-Id: <20180420.160653.391583024671680574.davem@davemloft.net>
To: tom.hromatka@oracle.com
Cc: sparclinux@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, allen.pais@oracle.com,
 khalid.aziz@oracle.com, shannon.nelson@oracle.com,
 anthony.yznaga@oracle.com
Subject: Re: [PATCH v3 0/2] sparc64: Add privileged ADI driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180420193939.487546-1-tom.hromatka@oracle.com>
References: <20180420193939.487546-1-tom.hromatka@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598287413064530122?=
X-GMAIL-MSGID: =?utf-8?q?1598297022408223854?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Something put your commit message texts completely into the subject
lines of the patch emails.

Please fix this and resubmit as v4.

Thank you.
