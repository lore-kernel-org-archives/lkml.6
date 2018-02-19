Return-Path: <outreachy-kernel+bncBCS4V27AVMBBBH5CVPKAKGQEWBPD37Y@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519046944; cv=pass;
        d=google.com; s=arc-20160816;
        b=wnFmIOYgWcPKShpi+ha9OAL/mn0SlSYq6EW6CCsnKJIAkwqzWoSCgE4Zp04CYwVIb8
         RPojkBJ3TCgK4S38WZ4c0PkhzckPJjWZWa2vzixjFWd5JaDx6prZgbaDqNInoyuALxnZ
         ypmwN5wLnFJjuY6BPjsYj11bjdWUmrMp4V/gCCptSeKapN4ym+AyQLc0cqrMCbZdOq+/
         rLKoCRSadj3sxsjzlWfblr8ARwxoWD/c0CA4Uigam8dNnqKxue3FOTLsO4vGPpRH+xMP
         A0so+F8VWSQCQ/skzSWIgGZY6iY/W0s/LG2qdPILm6qRMMONu2p8LjJrK+zCSniOatHp
         U8bg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=XygPNowZJd8XpqavBNwtIzMloIWayzDAL2TQW7rXKKw=;
        b=jpSvDekLvrvC/GIZF81VAjG2/nYW28RIpRMQqLdird4Cv2crwkfFLsj9yqO5uKOXqH
         yBgL6OOMRzSdMKc79stJUD/a6bGnqEFP6rJEtqUMuUmN7Ogx2ufmngd3SPQvxmDqFK9p
         AGEQGf2pCvQrgmoxLzx+lFmxASg4hcBLhCGGlxAzqVU4FaS+8LGesCITUHlyYYP6Ytcq
         qRCznzv8xio8AN6hnd8sEQbirfJmLMGY2ACzTekE2jbXao5wYQnSHxX7E8v97QMr7j7D
         ZMrA4xBkHdbaXf325jex6cY+2uZXVGQgxcWUIKTnOFhOTkobp6X0vKzgl/3hM/riN3UI
         BF0g==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=pdU3YIUA;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbcs4v27avmbbbh5cvpkakgqewbpd37y@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCS4V27AVMBBBH5CVPKAKGQEWBPD37Y@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=pdU3YIUA;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbcs4v27avmbbbh5cvpkakgqewbpd37y@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCS4V27AVMBBBH5CVPKAKGQEWBPD37Y@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1519046943; cv=pass;
        d=google.com; s=arc-20160816;
        b=PgZn2XgXG4N2KCVuC7tAd2iQ7yQiwfeKIXmU9c6k//LUeWzNI1wlhY4OTdntzaRG4J
         LooAICZn4sRSqxXP933g1QU/T3zkfnAot+cLCqVjMc5Ltg9T1N+nSangexqbAyvDwcbf
         2uJcQd4lrOpo4wN4smySZsi0a8qy7IiULvqC4aAkJmSF01hhx45q7Dl625ck1eSTjF9a
         IAFf0TRHviIFj0POoVLQ3LIP9J2TAaXEzrL5yOjwIlPtBVLkIi79mdzJkHSoywVJxFNa
         7Ph3qsYHgiqPBZZvAWSwSAfI24pGxRBrR/C0+GSU+2vfMQFeyIUdg04i+T6VxuEB4+pO
         sjPg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results;
        bh=XygPNowZJd8XpqavBNwtIzMloIWayzDAL2TQW7rXKKw=;
        b=RIpPXVK3GJQh3FDLUqNa7smnM00oTlHij9i5AkMqjVPZOWsA17isK5IZiVvK1Svvjh
         SGnvs7bbM8cEa9+c2cya7B7s4Qir2fOhOsj1q/n1PgmEODnJuIB7Z6XhetnP4mUWk/fn
         TQcBDN8VT5BjMjEI7E8FQvVtgfJ6Zvzr7JH9kM5F0b3rrVBq1l+S8dRXKQmnweeh08JN
         E5Q7LKGlQpMW5Ik6Fy8/JKdQDL3+YrRoaIjAvOr/j6pg+dcRa9ExO2bbYACtRLMH0lUX
         XlkPgkNnWmWBrNiExqeLht40x5dJ7nBDWzVQXuudArSGmjewsqIv/uY2K/xLlm3wm1yR
         tQsw==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x227FvBVCs/w9NuUqRUw2MjugsDjcrTMY8M+fuSlfqPSnZ9q5a6ZNfQZxQg63iIU2kvz2J3GZ0w==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519046942; cv=none;
        d=google.com; s=arc-20160816;
        b=C9Fp+h23+ScGPuKXSwtaKsscQVssXzqElCtHvRXpFcuVZL0667xHRBV45qmN/xxnwu
         5OINc3mVaqmHI9hXqJEouLTYjayEQIEoGOU36O7oNdGW+fQ+WBuEOpG0rh2oeHo5XFyO
         nw6N9t5+8VQzDDEH2XQRoMLF0TzPFroedR1Kigpq2xacbBzZ3Y92Urmk5EG3vZGycZ/j
         hd1DQU+sIBNJEaCve/8nqGwUnEPQU4lQxTSjgKGFdCTapa+G1/0pfpq/FcJQsUpamcE5
         n4YeAaTA6RmmjvS1NwRCSAkmasHDeK35cElygu1f2iwHIzXbZy35ts2VC9OiPYtYrEiO
         M0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=HcddmA3qJ0YwH7OUO0K6djiFISWO+C5jpIbVYF9UjmA=;
        b=ExIWdioe/qEpHfcQWOKiYkWwiphgvr8mPVo/utTqnNXOX8Tg2TXzu2odQsceIqPb8u
         vz2xCqoA0Nni0H+EEPD2qc70iIOw0TKloljMW8OV7oJPqzAyicPo+Us7vH+3epurZhFf
         6DpWggJeTSMFKijqUwufdLaKcNgakl0xjC3z5xcxu1GLfEREyeQ4jy9SO/nri45qPKJK
         RwGcVgUrUFRz5bTaR9L1Qo6Kmf26YaoHlLqdizqdkFrZNPxc68i50py8bxdcIQ0RvT+X
         tTfZT79jAs6zcutrkZAJrtqiWbrOlvZXumxPrbIYFOWKX8QCHs4+fBKz3GD5x3C+WdOF
         /rEg==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
From: Richard Weinberger <richard@nod.at>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: boris.brezillon@free-electrons.com, dwmw2@infradead.org, computersforpeace@gmail.com, marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr, maximlevitsky@gmail.com, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, ezequiel@vanguardiasur.com.ar, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH NAND v2] mtd: nand: Replace printk()
 with appropriate pr_*macro()
Date: Mon, 19 Feb 2018 14:30:11 +0100
Message-ID: <5296610.PbIriun04K@blindfold>
In-Reply-To: <1519046025-9412-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1519046025-9412-1-git-send-email-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Original-Sender: richard@nod.at
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning richard@nod.at does not designate
 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592835215641943440?=
X-GMAIL-MSGID: =?utf-8?q?1592836168198977766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Shreeya,

Am Montag, 19. Februar 2018, 14:13:45 CET schrieb Shreeya Patel:
> The log levels embedded with the name are more concise than
> printk.
> Replace printks having a log level with the appropriate
> pr_*macro.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>

Multiple patches with the same subject are confusing. :)

Thanks,
//richard 

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/5296610.PbIriun04K%40blindfold.
For more options, visit https://groups.google.com/d/optout.
