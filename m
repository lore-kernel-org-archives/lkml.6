Return-Path: <jmorris@namei.org>
X-Google-Smtp-Source: AB8JxZp3rYb/hx+EoK8PiMUIm+1F4mmx9smC+UVJo37QKc7F9UmMfDxw9JoTIQ96SZ1IiNK9Xt+8
ARC-Seal: i=1; a=rsa-sha256; t=1525893858; cv=none;
        d=google.com; s=arc-20160816;
        b=1D488SCzDUgBCE8HdO0FoBjb6GJ4ColM3kheAglDQtFjOoDNZO6ZTMFEBLUP92qI+y
         ahCixQapQObdsy96KjrCJNYF2aUzHUE9QZaZjJsKAoDEIbGNQdDZlD695bYyL7lHt343
         /X8cLSHT9LMKiz2B3Zjv0LRV7nVX9byxTblIvg4lL2u4G7QHOoJip+vXVyc69d48YMIP
         NsaoNo3Tu1fvyamR4xDP4I7SnQG1co8CZ7myqEW4rZvfT0SSQydeOJtcRRHj0IC9Fh2M
         pY1LRtr9XXZ2vtaSSDesp3T3z3bBajz3GrkVSKPsZiglL+EWMOvnX05mQjwisK/ImTUM
         Mleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=SzHIkdJqw7l7SKbBPiRC8u3lGfl6F4AKjAY2od99dyU=;
        b=BFXpDGiOrar7rWiSYnmRXY8Vm+eI7M5eda4je5gHtV3TNROtWjilgQgz42t0jz09LC
         lCD7jedzOU892EozCNnVFDM6cGD80Ge5YIqlKzFsUn8eyhPM2xVlZozY04JntNDzOmO6
         SebYH9uCUtV+KUjj7hVZICEV1Sc+YpWYe5VmTIf6qDbZeeLbEJ2X/dkdaRPwaoXWU/M7
         Pi6lKEJyXsPJN4ICZ/OTeMoUaNzirRuLzaZxsFRV7v4Gz3YJFvxQyRgAHU7fDFCbovnn
         lSyMEtiQZRr974nZeeGanSBiuCgn+jI/28zvFgPA9N1FFHv73QSBAnjXMnwgNwvBxq8u
         St3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jmorris@namei.org designates 65.99.196.166 as permitted sender) smtp.mailfrom=jmorris@namei.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jmorris@namei.org designates 65.99.196.166 as permitted sender) smtp.mailfrom=jmorris@namei.org
Date: Thu, 10 May 2018 05:22:44 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Harry Wei <harryxiyou@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Roy Pledge <Roy.Pledge@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-gpio@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@zh-kernel.org, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 11/11] docs: fix broken references with multiple
 hints
In-Reply-To: <63a4f8a93f9115475bc184d0f37d076c9b9c75ff.1525870886.git.mchehab+samsung@kernel.org>
Message-ID: <alpine.LRH.2.21.1805100522240.12749@namei.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org> <63a4f8a93f9115475bc184d0f37d076c9b9c75ff.1525870886.git.mchehab+samsung@kernel.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599992738415856815?=
X-GMAIL-MSGID: =?utf-8?q?1600015677867765244?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 9 May 2018, Mauro Carvalho Chehab wrote:

> The script:
> 	./scripts/documentation-file-ref-check --fix-rst
> 
> Gives multiple hints for broken references on some files.
> Manually use the one that applies for some files.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>


Acked-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
