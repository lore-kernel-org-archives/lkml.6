Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48AF7Rx5TmJbeEtyobP14+6pxxnwMpFb6/8nN1bcP5dpdLgd/KkaHnJo1eDWyf9NN+uM06G
ARC-Seal: i=1; a=rsa-sha256; t=1523568989; cv=none;
        d=google.com; s=arc-20160816;
        b=y4ddVIzHpRMY427K01CK9cUPhDMVieoILquVAx8osV3cjkcgCVOTO/IvOpX1RK3jFi
         ohOeYeQ2gJTIuPnf1OaNS2z5iz2U9qNwo7O8N4ke9oeqhJK841E456jbo0BleSM2evM6
         FpyIVec8XryqeuQMeEs0dfkp3nHTDqrgspay6Rf6yb7A5AwswNqhKEknsu5uTtXhJUva
         fcXENtj0YEFq4KqK+Z4vedtnl4jrlMy5Lb7J6Eo4NbO/QyzGKP0DK6xYoyzv8ojg3LTy
         +5SJ6sAEFtdNxabC2f5UkfbHX5CFa67keaUDFCA0dollEvV8hdax7OLZp7ebiZNPDOE2
         1fWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=RbdeHjWfJxETfayiCG/Y6tessw5FOPhJDSjUpbmL9Go=;
        b=YH3vcrgzr25tktCFC/2xJUXuIlZl/0iaeQazNac/0fO/7/CJDxERRhmL8vTx2rXHce
         zLoQdR8C3h5777FYL+pVeD19/z1mP2Et8a9HAZ+SzwxhygqgSwcQSUsHSkkbVm/mBweL
         DpGR68DAmk9iY+wLLeLtiCIEVOZceMjfljvBPbqKbGYLtQ4JHJKfUNDWLJA8uK5EbKbl
         rWsTPDoUzYkP1TwTL+9VC+8kk5xxjP/4SIwID/pJqSLnl9PoYgrExfIV9/xD1ksi4ih5
         MKtXArzXzmL2iCezmElI2bXwkNPrYsOPQBAD8dOBx2Bl2d6by9wTgPMGOIxVcnOgnZur
         o4AA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeDLVgR (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 12 Apr 2018 17:36:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752298AbeDLVgQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Apr 2018 17:36:16 -0400
Date: Thu, 12 Apr 2018 16:36:14 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Libor =?utf-8?B?UGVjaMOhxI1law==?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH v3] selftests/livepatch: introduce tests
Message-ID: <20180412213614.fqhdqesue3vqebdk@treble>
References: <1523544871-29444-1-git-send-email-joe.lawrence@redhat.com>
 <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597552611970926096?=
X-GMAIL-MSGID: =?utf-8?q?1597577877092021621?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 10:54:31AM -0400, Joe Lawrence wrote:
> Add a few livepatch modules and simple target modules that the included
> regression suite can run tests against.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

(assuming it's merged after the other two patch sets it depends on)

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
