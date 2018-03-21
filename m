Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeCUQvN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:51:13 -0400
Received: from smtp-1b.atlantis.sk ([80.94.52.26]:50206 "EHLO
        smtp-1b.atlantis.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752640AbeCUQvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:51:09 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Robert Munteanu <rombert@apache.org>
Subject: Re: [PATCH v3] Fix modifier keys for Redragon Asura Keyboard
Date: Wed, 21 Mar 2018 17:51:04 +0100
User-Agent: KMail/1.9.10 (enterprise35 0.20100827.1168748)
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <20180321104331.22783-1-rombert@apache.org>
In-Reply-To: <20180321104331.22783-1-rombert@apache.org>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201803211751.04734.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 March 2018 11:43:31 Robert Munteanu wrote:
> +#define USB_VENDOR_ID_MICRODIA          0x0c45
> +#define USB_DEVICE_ID_REDRAGON_ASURA    0x760b

Microdia is most probably an incorrect name. The 0c45 id probably belongs 
to "Sonix Technology Co., Ltd."

-- 
Ondrej Zary
