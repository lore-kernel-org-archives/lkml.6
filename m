Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524578374; cv=none;
        d=google.com; s=arc-20160816;
        b=Eq103CjHiUjZRvAb4X8hZvlDaBQxesKHqFs8W8T1r8xeEjEpfQBdj6OwKsEn1TQE91
         z1SmNjQnQ3XKFoCZ/Q6JXDvztSXUqJmyXAdyh65BIHBEOIzsZFmVzf8KcWm1Bg14s5UC
         peJmH5xYYuYhhO1dd4SdvvbwPtSdURXsRvNpGqNAP6wsMZIuvxuoBDrXK1n0Z1mwVv3G
         Tq+qSYaUQORiiVi/Ag3qXyHzCdwEB0dStioad5ifUqxPz8hPoGZBfQ/n00+kAtL7xe/K
         U3KdJZddHcWW94/G5Y5zFoLyHYsRk1lEp6EHUDPM2esZ8g/hukuM/gwJoyh0gmdBUqVQ
         S20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=VRiKi4xhOQYs38X6kS6w87/Fj08tE9IKeZhXuIXYjT4=;
        b=gakj7ta8Yf7GCwDOXrZ+OlnMADywLX7fqgTNyEC7Gc/ASWNwjzDmKi5BY6GSeD8uAz
         oktfFQYKlzwL/kn1y3b85w1Rn2tBz7oYvfMjEePTs9mizypgHwR5S+SII5l+BYxm37Of
         Od9ZH3dBJpobS64lLFAWim7dK8KW2hI44RL8fs8ttMFtX9iwYzDKFvtlvrV8yXymINX8
         qjzYz8yV9RE3LruI9x+PCgyyGJpWWdTFmhpANShQ4sVVGLI9Aj/CcLkM7jHkBsZLp5Ll
         waJoqNgme/sn23nV/AKu6iKpf7W3VDVxTC0Y/wfa5L+IKAt2bl4Mh5Y1NPp5tQFYMGUg
         Si0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZp50ULhaGMBCf0yAlykrzpMgyYRgxyw9+mTxNT2hdAUpQSO+vWs6Y36UzuHppH6EOOOxJeITw==
Date: Tue, 24 Apr 2018 08:59:32 -0500
From: Rob Herring <robh@kernel.org>
To: Yossi Mansharoff <yossim@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, swboyd@chromium.org
Subject: Re: [PATCH v2] doc: usb: ci-hdrc-usb2: Add property "mux-controls"
Message-ID: <20180424135932.hsua6kjas5b5drdy@rob-hp-laptop>
References: <1523973206-2165-1-git-send-email-yossim@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523973206-2165-1-git-send-email-yossim@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598001755221785817?=
X-GMAIL-MSGID: =?utf-8?q?1598636293493733701?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 04:53:25PM +0300, Yossi Mansharoff wrote:
> The chipidea usb controller may be connected, in some platforms,
> to an external mux to toggle between different usb ports for
> different roles (host and device).
> 
> The mux-controller property, if set, binds the chipidea usb
> controller with a mux for this use.
> 
> Signed-off-by: Yossi Mansharoff <yossim@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
