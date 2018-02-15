Return-Path: <tv@lio96.de>
X-Google-Smtp-Source: AH8x225d7LqTzSUGpmB0BPTYcwniLSLCLsnEGOUAQ1oY+eS/x5sS0+/2j2F91qnnEBb11XXw+Sfh
ARC-Seal: i=1; a=rsa-sha256; t=1518689745; cv=none;
        d=google.com; s=arc-20160816;
        b=I8PeJKwKL+R1Lce6rti8vNZ33llH599FZ+ca/V3VYBbSC+aDRa3/4euQqaM5kYP9CA
         np/byR1/987OkKTEguIbkFkAIQmM24NbTGnMiskBAe90fN5QiOmJD6Xhh+6D87szRA87
         BUXr4qaMF/7LOJkothhZVXbkkPH8pQicwqa9exD8932OcOs77IVe/ix0uBi76SXL+17K
         KqGweZ6PauDOYpL/z8nH9F8riEwxFoBSVrxZsTG9/z8AMQDOSjh5m4YLF8WBZm7YkVlp
         Vf6ESxg0f2WOB+TksOHsgEb4ekHPeLPbXvxAbobIbNkDM3BuI2OgDqmFI+fPq9Fltb9e
         HOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=JH03b+53Mnje5EDJPJKDwOh90vPT28nFgnUvYe4ed7o=;
        b=RPnqBQJLnLvc/G7+oDAWk9JX6SJhJws4RKIGT2QZW5f8aMnPv2GQhtpjsW7WP6U3Lq
         Y2T7iMb3gIDDu1BD0WLzXyhG7VBxny8xlyN52woY1U2ObCPTgboijuk+izi2WoQfKkM2
         XdX7xsZ1XVBfI+ng8UmwjpkJ92xFVcJv+XRKrQ1SnORmvYnS3SnGQZsUxyoewDwJQ58y
         sW/2/VFYhunByZyTlnc/ONfiEUoUa3IQ9bSHSrPwA7f0W0pMhVwQ73rjpHWD5CW2HEtL
         SJTl5Ir2VlKdIPgEFbhI/udAj4+8lcY/7hnsdYP8kVAt3d1CZvTT1qTAm7+JQbB5qHWa
         I3FQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.251.68.21 is neither permitted nor denied by best guess record for domain of tv@lio96.de) smtp.mailfrom=tv@lio96.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.251.68.21 is neither permitted nor denied by best guess record for domain of tv@lio96.de) smtp.mailfrom=tv@lio96.de
Date: Thu, 15 Feb 2018 11:15:41 +0100 (CET)
From: Thomas Voegtle <tv@lio96.de>
X-X-Sender: thomas@er-systems.de
To: David Woodhouse <dwmw@amazon.co.uk>
cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>,
    =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
    linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
    KarimAllah Ahmed <karahmed@amazon.de>, gregkh@linuxfoundation.org,
    stable@vger.kernel.org
Subject: Re: [STABLE 4.9.y PATCH 0/9] Backport of KVM Speculation Control
 support
In-Reply-To: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
Message-ID: <alpine.LSU.2.20.1802151109550.14387@er-systems.de>
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 0.99.3/24316/Thu Feb 15 02:21:10 2018 signatures .
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591673557127781452?=
X-GMAIL-MSGID: =?utf-8?q?1592461618699397236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hello,

On Tue, 6 Feb 2018, David Woodhouse wrote:

> I've put together a linux-4.9.y branch at
> http://git.infradead.org/retpoline-stable.git/shortlog/refs/heads/linux-4.9.y


Are there any plans for a backport to v4.4?

I would volunteer for testing ;)


     Thomas
