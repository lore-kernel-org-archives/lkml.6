Return-Path: <evgreen@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526074196; cv=none;
        d=google.com; s=arc-20160816;
        b=zR1nG7AvyQoszna0cXzeO/EbsbsgOmLKwEjqKfwqCb0yn+ZsAwX4zK4CwwVOLbZIXE
         vam2fIu6C/Cga0YGZWbgKg5GPgdYA0JYSJUT5iSoYancclB92tuSDqZ77+F7/v3GCmGW
         vpJIMmdW7nIZKHPtltEZ+1X0Xm+YzzhsqjA1vzTaM5ggn5oIj/aW5coHvha0158D9xkf
         3UnFZGAiaiiOTk1+ayZtrAfkTtz3rf6rDzPRsk4LiWpn9bTnAzc16sGMSx/s60vXXj0+
         BCUQX3zOih8vKUCLWY80+aHfZiOAc/MiwcSTy8r5l4oMY5eBd1g4qudtMX5BDzsvViFR
         xVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=2qENnaIX9CYOgjGRoHgiT8OCBVVoQDSVsmGdh9Xi0dU=;
        b=CrltdEVBUUYF//NbVfXyb/ZNISZn1S+pUOYLl/2sE+zyXmeJQGDPoOoK6EJ7WkEopS
         Z+jo/5vv6rnt4IUjt2idRh5batO1Fy5Um7ElKcX+VRf3/Lb+mpTe3/uiuamSa5y+ThU9
         7hQ/8ryl4Lt2LwEezIq22/E4OVM/8xILzsJ8Sa6SfZsAXDQflGKKJ/AA9NUcctYVGpHU
         uS7mgW5kLn+EOHIcxof71g6hTLg/DheB8cobtGC7ZPvZwF5LzhZlcetrQPmAH4Df4NkI
         6tDzjS1Ckfoj2mCZ1z3RfxR27NHEh8cc71HY81DInbKWAtOl1ULFjov2jCkG8o5HqaUp
         yejg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=aDk3Meib;
       spf=pass (google.com: domain of evgreen@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=evgreen@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=aDk3Meib;
       spf=pass (google.com: domain of evgreen@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=evgreen@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZoZw8GSJ9FYlTIpKM479E/WaRkYeRUmpNCqSm9Zr6cHp3b02QAXo/7G7E4mvt7uaMyglMquaQ==
MIME-Version: 1.0
References: <20180309210958.16672-1-georgi.djakov@linaro.org> <20180309210958.16672-8-georgi.djakov@linaro.org>
In-Reply-To: <20180309210958.16672-8-georgi.djakov@linaro.org>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 11 May 2018 14:29:19 -0700
X-Gmail-Original-Message-ID: <CAE=gft4-gBsdmwVOModwq1iNw91phc0Zp9Qvy8jqPiBYo4Zp5A@mail.gmail.com>
Message-ID: <CAE=gft4-gBsdmwVOModwq1iNw91phc0Zp9Qvy8jqPiBYo4Zp5A@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] interconnect: Allow endpoints translation via DT
To: georgi.djakov@linaro.org
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net,
	robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com,
	vincent.guittot@linaro.org, skannan@codeaurora.org,
	Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org,
	seansw@qti.qualcomm.com, davidai@quicinc.com, mark.rutland@arm.com,
	lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495931519090821?=
X-GMAIL-MSGID: =?utf-8?q?1600204777154644689?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 1:10 PM Georgi Djakov <georgi.djakov@linaro.org>
wrote:

> Currently we support only platform data for specifying the interconnect
> endpoints. As now the endpoints are hard-coded into the consumer driver
> this may leed to complications when a single driver is used by multiple

Nit: s/leed/lead/

-Evan
