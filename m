Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AIpwx4/ueFtr6Kl5P4jjNVH16noyR0+lqNVdU9+xJJ6dWfcwsQuHv+CawKUna52l385E6QCJZVi6
ARC-Seal: i=1; a=rsa-sha256; t=1524492658; cv=none;
        d=google.com; s=arc-20160816;
        b=UxX9EikI9RgxgV+lPpixfmQXt6J4CDlO+6XlMGBQE3bmbaZV1CB+2BRQ91NFFgPHSL
         O8+AE49TfzvFnrnA8jhKR4E2De4dXuda1yUiS7LigQuU49NhTiOXacojzNHCDuiEPaL+
         SmYrqHHETAM0z6ss/GY67qqmKDPx3BoMT2Gzwa6QVz+yeZvynEvicwoCDQ6KiEj108OU
         t1bDp31m/awE0pkGKT0jDi86v1pUZXVPnpxc7O+rKHYVMy9venfHthef2jW2XhU5+s6T
         WrO5EA6GTKAJqUGa0jYKwbgFA5Rv/glKRxgZ4AMfhmTM9VL3X52N6lrczlZm6sKT2q5p
         zx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:cc:to:subject:date:from:references:in-reply-to
         :message-id:arc-authentication-results;
        bh=rjgPhIazokcaMS6pEuPlauvFIQSxR0/cgrEJVjOZUS4=;
        b=txTn55nMyv4YOgsgkmFRougYJ+lf5IrmUgnjcy28tYOxj9mIEAvsqcgS88LYYHAZ1k
         xuGsM8vhUzwSPUudMoxVpSO4DDRZbL8WfalsLIHjiqY2dZEdeNhBDE5FZOioEa6oeIVw
         0o+IrAtEUl9c/X5Nhc9C0aHDWPYxuXe8fn95JAZGBkPcBCfhUS+CKdijk0p1RqgxZe+i
         g8fej7iUNR6mTXoBG9POgdXO43fXWIHqt9gwfGsN4ChKVFQFO8fhxbA5hpsm4s3rXOas
         Y4dJtV5gLU88ZvwRtIE4X11nznpL1486JKVoBgKsBjGpvoPV+y3461FZ8oaqyAQzITD4
         b3jQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 195.245.231.139 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 195.245.231.139 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleJIrShJLcpLzFFi42KJ27nUWLfw5d0
  og58H5S2aF69ns3hzfDqTRdfqnSwW1471Mllc3jWHzeJz7xFGi0XLWpktniw8w2RxeneJA6fH
  plWdbB7zTgZ67J+7ht1j47sdTB7v911l89j5vYHd4/MmuQD2KNbMvKT8igTWjL3PYgqmXGWs+
  HPxNXsD4691jF2MXBxCAusZJWZNbQRyOIGcColTt9Yzgdi8ApkSj//NZgexOQXcJbonfWSDqH
  GTuNz2BqyeTcBCYvKJB0BxDg4WAVWJq1ecQcLCQOUti+ezg8wXEXjPKPHp8QcWkASzQJ1E7++
  3LBDzBSVOznwCFZeQOPjiBTPEfAOJ0wsaweISAvYS099fZQaZLyGgL9F4LBYibCjxfdY3qBJz
  ifuHu9gmMArOQjJ1FpKpCxiZVjFqFKcWlaUW6Rob6CUVZaZnlOQmZuboGhqY6uWmFhcnpqfmJ
  CYV6yXn525iBEZJPQMD4w7GCav8DjFKcjApifJanr8bJcSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0
  mCt+IFUE6wKDU9tSItMwcYrzBpCQ4eJRHeOJA0b3FBYm5xZjpE6hSjLse/m/t7mYVY8vLzUqX
  EeV1BigRAijJK8+BGwFLHJUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvJtBpvBk5pXAbXoF
  dAQT0BEdkndAjihJREhJNTCaqWm11FVObnx+3v+CjY+7gOAR2W87P6TtjvPgjLt6NGP55/mb6
  5Suq8xx3f1Ib+02djlPXtk4Ye73EbIdahcaJG/38f37U+vKq7Ytbxbz4+iZmR45S26s/nlo1p
  40Hs6Npn5SYf0iBbus92eKeWZJvDsf26M6T1VQf/v6nzMumOi9yNrcxajEUpyRaKjFXFScCAA
  uLX6hGAMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-16.tower-180.messagelabs.com!1524492656!99333180!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <34c58a40afac0b97375fc76a343d5fd41057fafa.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Mon, 23 Apr 2018 15:10:56 +0100
Subject: [PATCH v8 1/6] typec: tcpm: Add core support for sink side PPS
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck
	<linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jun
 Li <jun.li@nxp.com>
CC: <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 23/04/2018 11:44:00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595722898650865988?=
X-GMAIL-MSGID: =?utf-8?q?1598546413541538846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds code to handle requesting of PPS APDOs. Switching
between standard PDOs and APDOs, and re-requesting an APDO to
modify operating voltage/current will be triggered by an
external call into TCPM.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/typec/tcpm.c | 569 +++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/usb/pd.h   |   4 +-
 include/linux/usb/tcpm.h |   1 +
 3 files changed, 558 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 27192083..b160da3 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -48,6 +48,7 @@
 	S(SNK_DISCOVERY_DEBOUNCE_DONE),		\
 	S(SNK_WAIT_CAPABILITIES),		\
 	S(SNK_NEGOTIATE_CAPABILITIES),		\
+	S(SNK_NEGOTIATE_PPS_CAPABILITIES),	\
 	S(SNK_TRANSITION_SINK),			\
 	S(SNK_TRANSITION_SINK_VBUS),		\
 	S(SNK_READY),				\
@@ -167,6 +168,16 @@ struct pd_mode_data {
 	struct typec_altmode_desc altmode_desc[SVID_DISCOVERY_MAX];
 };
 
+struct pd_pps_data {
+	u32 min_volt;
+	u32 max_volt;
+	u32 max_curr;
+	u32 out_volt;
+	u32 op_curr;
+	bool supported;
+	bool active;
+};
+
 struct tcpm_port {
 	struct device *dev;
 
@@ -235,6 +246,7 @@ struct tcpm_port {
 	struct completion swap_complete;
 	int swap_status;
 
+	unsigned int negotiated_rev;
 	unsigned int message_id;
 	unsigned int caps_count;
 	unsigned int hard_reset_count;
@@ -258,6 +270,7 @@ struct tcpm_port {
 	unsigned int nr_snk_vdo;
 
 	unsigned int operating_snk_mw;
+	bool update_sink_caps;
 
 	/* Requested current / voltage */
 	u32 current_limit;
@@ -274,8 +287,13 @@ struct tcpm_port {
 	/* VDO to retry if UFP responder replied busy */
 	u32 vdo_retry;
 
-	/* Alternate mode data */
+	/* PPS */
+	struct pd_pps_data pps_data;
+	struct completion pps_complete;
+	bool pps_pending;
+	int pps_status;
 
+	/* Alternate mode data */
 	struct pd_mode_data mode_data;
 	struct typec_altmode *partner_altmode[SVID_DISCOVERY_MAX];
 	struct typec_altmode *port_altmode[SVID_DISCOVERY_MAX];
@@ -493,6 +511,16 @@ static void tcpm_log_source_caps(struct tcpm_port *port)
 				  pdo_max_voltage(pdo),
 				  pdo_max_power(pdo));
 			break;
+		case PDO_TYPE_APDO:
+			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS)
+				scnprintf(msg, sizeof(msg),
+					  "%u-%u mV, %u mA",
+					  pdo_pps_apdo_min_voltage(pdo),
+					  pdo_pps_apdo_max_voltage(pdo),
+					  pdo_pps_apdo_max_current(pdo));
+			else
+				strcpy(msg, "undefined APDO");
+			break;
 		default:
 			strcpy(msg, "undefined");
 			break;
@@ -790,11 +818,13 @@ static int tcpm_pd_send_source_caps(struct tcpm_port *port)
 		msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
 					  port->pwr_role,
 					  port->data_role,
+					  port->negotiated_rev,
 					  port->message_id, 0);
 	} else {
 		msg.header = PD_HEADER_LE(PD_DATA_SOURCE_CAP,
 					  port->pwr_role,
 					  port->data_role,
+					  port->negotiated_rev,
 					  port->message_id,
 					  port->nr_src_pdo);
 	}
@@ -815,11 +845,13 @@ static int tcpm_pd_send_sink_caps(struct tcpm_port *port)
 		msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
 					  port->pwr_role,
 					  port->data_role,
+					  port->negotiated_rev,
 					  port->message_id, 0);
 	} else {
 		msg.header = PD_HEADER_LE(PD_DATA_SINK_CAP,
 					  port->pwr_role,
 					  port->data_role,
+					  port->negotiated_rev,
 					  port->message_id,
 					  port->nr_snk_pdo);
 	}
@@ -1186,6 +1218,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 		msg.header = PD_HEADER_LE(PD_DATA_VENDOR_DEF,
 					  port->pwr_role,
 					  port->data_role,
+					  port->negotiated_rev,
 					  port->message_id, port->vdo_count);
 		for (i = 0; i < port->vdo_count; i++)
 			msg.payload[i] = cpu_to_le32(port->vdo_data[i]);
@@ -1257,6 +1290,8 @@ enum pdo_err {
 	PDO_ERR_FIXED_NOT_SORTED,
 	PDO_ERR_VARIABLE_BATT_NOT_SORTED,
 	PDO_ERR_DUPE_PDO,
+	PDO_ERR_PPS_APDO_NOT_SORTED,
+	PDO_ERR_DUPE_PPS_APDO,
 };
 
 static const char * const pdo_err_msg[] = {
@@ -1272,6 +1307,10 @@ enum pdo_err {
 	" err: Variable/Battery supply pdos should be in increasing order of their minimum voltage",
 	[PDO_ERR_DUPE_PDO] =
 	" err: Variable/Batt supply pdos cannot have same min/max voltage",
+	[PDO_ERR_PPS_APDO_NOT_SORTED] =
+	" err: Programmable power supply apdos should be in increasing order of their maximum voltage",
+	[PDO_ERR_DUPE_PPS_APDO] =
+	" err: Programmable power supply apdos cannot have same min/max voltage and max current",
 };
 
 static enum pdo_err tcpm_caps_err(struct tcpm_port *port, const u32 *pdo,
@@ -1321,6 +1360,26 @@ static enum pdo_err tcpm_caps_err(struct tcpm_port *port, const u32 *pdo,
 					  pdo_min_voltage(pdo[i - 1])))
 					return PDO_ERR_DUPE_PDO;
 				break;
+			/*
+			 * The Programmable Power Supply APDOs, if present,
+			 * shall be sent in Maximum Voltage order;
+			 * lowest to highest.
+			 */
+			case PDO_TYPE_APDO:
+				if (pdo_apdo_type(pdo[i]) != APDO_TYPE_PPS)
+					break;
+
+				if (pdo_pps_apdo_max_current(pdo[i]) <
+				    pdo_pps_apdo_max_current(pdo[i - 1]))
+					return PDO_ERR_PPS_APDO_NOT_SORTED;
+				else if (pdo_pps_apdo_min_voltage(pdo[i]) ==
+					  pdo_pps_apdo_min_voltage(pdo[i - 1]) &&
+					 pdo_pps_apdo_max_voltage(pdo[i]) ==
+					  pdo_pps_apdo_max_voltage(pdo[i - 1]) &&
+					 pdo_pps_apdo_max_current(pdo[i]) ==
+					  pdo_pps_apdo_max_current(pdo[i - 1]))
+					return PDO_ERR_DUPE_PPS_APDO;
+				break;
 			default:
 				tcpm_log_force(port, " Unknown pdo type");
 			}
@@ -1346,11 +1405,16 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
 /*
  * PD (data, control) command handling functions
  */
+
+static int tcpm_pd_send_control(struct tcpm_port *port,
+				enum pd_ctrl_msg_type type);
+
 static void tcpm_pd_data_request(struct tcpm_port *port,
 				 const struct pd_message *msg)
 {
 	enum pd_data_msg_type type = pd_header_type_le(msg->header);
 	unsigned int cnt = pd_header_cnt_le(msg->header);
+	unsigned int rev = pd_header_rev_le(msg->header);
 	unsigned int i;
 
 	switch (type) {
@@ -1369,6 +1433,17 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 				   port->nr_source_caps);
 
 		/*
+		 * Adjust revision in subsequent message headers, as required,
+		 * to comply with 6.2.1.1.5 of the USB PD 3.0 spec. We don't
+		 * support Rev 1.0 so just do nothing in that scenario.
+		 */
+		if (rev == PD_REV10)
+			break;
+
+		if (rev < PD_MAX_REV)
+			port->negotiated_rev = rev;
+
+		/*
 		 * This message may be received even if VBUS is not
 		 * present. This is quite unexpected; see USB PD
 		 * specification, sections 8.3.3.6.3.1 and 8.3.3.6.3.2.
@@ -1389,6 +1464,20 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 			tcpm_queue_message(port, PD_MSG_CTRL_REJECT);
 			break;
 		}
+
+		/*
+		 * Adjust revision in subsequent message headers, as required,
+		 * to comply with 6.2.1.1.5 of the USB PD 3.0 spec. We don't
+		 * support Rev 1.0 so just reject in that scenario.
+		 */
+		if (rev == PD_REV10) {
+			tcpm_queue_message(port, PD_MSG_CTRL_REJECT);
+			break;
+		}
+
+		if (rev < PD_MAX_REV)
+			port->negotiated_rev = rev;
+
 		port->sink_request = le32_to_cpu(msg->payload[0]);
 		tcpm_set_state(port, SRC_NEGOTIATE_CAPABILITIES, 0);
 		break;
@@ -1413,6 +1502,15 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 	}
 }
 
+static void tcpm_pps_complete(struct tcpm_port *port, int result)
+{
+	if (port->pps_pending) {
+		port->pps_status = result;
+		port->pps_pending = false;
+		complete(&port->pps_complete);
+	}
+}
+
 static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 				 const struct pd_message *msg)
 {
@@ -1489,6 +1587,14 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 				next_state = SNK_WAIT_CAPABILITIES;
 			tcpm_set_state(port, next_state, 0);
 			break;
+		case SNK_NEGOTIATE_PPS_CAPABILITIES:
+			/* Revert data back from any requested PPS updates */
+			port->pps_data.out_volt = port->supply_voltage;
+			port->pps_data.op_curr = port->current_limit;
+			port->pps_status = (type == PD_CTRL_WAIT ?
+					    -EAGAIN : -EOPNOTSUPP);
+			tcpm_set_state(port, SNK_READY, 0);
+			break;
 		case DR_SWAP_SEND:
 			port->swap_status = (type == PD_CTRL_WAIT ?
 					     -EAGAIN : -EOPNOTSUPP);
@@ -1511,6 +1617,13 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 	case PD_CTRL_ACCEPT:
 		switch (port->state) {
 		case SNK_NEGOTIATE_CAPABILITIES:
+			port->pps_data.active = false;
+			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
+			break;
+		case SNK_NEGOTIATE_PPS_CAPABILITIES:
+			port->pps_data.active = true;
+			port->supply_voltage = port->pps_data.out_volt;
+			port->current_limit = port->pps_data.op_curr;
 			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
 			break;
 		case SOFT_RESET_SEND:
@@ -1665,6 +1778,7 @@ static int tcpm_pd_send_control(struct tcpm_port *port,
 	memset(&msg, 0, sizeof(msg));
 	msg.header = PD_HEADER_LE(type, port->pwr_role,
 				  port->data_role,
+				  port->negotiated_rev,
 				  port->message_id, 0);
 
 	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
@@ -1780,6 +1894,8 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
 		     min_snk_mv = 0;
 	int ret = -EINVAL;
 
+	port->pps_data.supported = false;
+
 	/*
 	 * Select the source PDO providing the most power which has a
 	 * matchig sink cap.
@@ -1788,30 +1904,59 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
 		u32 pdo = port->source_caps[i];
 		enum pd_pdo_type type = pdo_type(pdo);
 
-		if (type == PDO_TYPE_FIXED) {
+		switch (type) {
+		case PDO_TYPE_FIXED:
 			max_src_mv = pdo_fixed_voltage(pdo);
 			min_src_mv = max_src_mv;
-		} else {
+			break;
+		case PDO_TYPE_BATT:
+		case PDO_TYPE_VAR:
 			max_src_mv = pdo_max_voltage(pdo);
 			min_src_mv = pdo_min_voltage(pdo);
+			break;
+		case PDO_TYPE_APDO:
+			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS)
+				port->pps_data.supported = true;
+			continue;
+		default:
+			tcpm_log(port, "Invalid source PDO type, ignoring");
+			continue;
 		}
 
-		if (type == PDO_TYPE_BATT) {
-			src_mw = pdo_max_power(pdo);
-		} else {
+		switch (type) {
+		case PDO_TYPE_FIXED:
+		case PDO_TYPE_VAR:
 			src_ma = pdo_max_current(pdo);
 			src_mw = src_ma * min_src_mv / 1000;
+			break;
+		case PDO_TYPE_BATT:
+			src_mw = pdo_max_power(pdo);
+			break;
+		case PDO_TYPE_APDO:
+			continue;
+		default:
+			tcpm_log(port, "Invalid source PDO type, ignoring");
+			continue;
 		}
 
 		for (j = 0; j < port->nr_snk_pdo; j++) {
 			pdo = port->snk_pdo[j];
 
-			if (pdo_type(pdo) == PDO_TYPE_FIXED) {
-				min_snk_mv = pdo_fixed_voltage(pdo);
+			switch (pdo_type(pdo)) {
+			case PDO_TYPE_FIXED:
 				max_snk_mv = pdo_fixed_voltage(pdo);
-			} else {
-				min_snk_mv = pdo_min_voltage(pdo);
+				min_snk_mv = max_snk_mv;
+				break;
+			case PDO_TYPE_BATT:
+			case PDO_TYPE_VAR:
 				max_snk_mv = pdo_max_voltage(pdo);
+				min_snk_mv = pdo_min_voltage(pdo);
+				break;
+			case PDO_TYPE_APDO:
+				continue;
+			default:
+				tcpm_log(port, "Invalid sink PDO type, ignoring");
+				continue;
 			}
 
 			if (max_src_mv <= max_snk_mv &&
@@ -1832,6 +1977,103 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
 	return ret;
 }
 
+#define min_pps_apdo_current(x, y)	\
+	min(pdo_pps_apdo_max_current(x), pdo_pps_apdo_max_current(y))
+
+static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
+{
+	unsigned int i, j, max_mw = 0, max_mv = 0;
+	unsigned int min_src_mv, max_src_mv, src_ma, src_mw;
+	unsigned int min_snk_mv, max_snk_mv, snk_ma;
+	u32 pdo;
+	unsigned int src_pdo = 0, snk_pdo = 0;
+
+	/*
+	 * Select the source PPS APDO providing the most power while staying
+	 * within the board's limits. We skip the first PDO as this is always
+	 * 5V 3A.
+	 */
+	for (i = 1; i < port->nr_source_caps; ++i) {
+		pdo = port->source_caps[i];
+
+		switch (pdo_type(pdo)) {
+		case PDO_TYPE_APDO:
+			if (pdo_apdo_type(pdo) != APDO_TYPE_PPS) {
+				tcpm_log(port, "Not PPS APDO (source), ignoring");
+				continue;
+			}
+
+			min_src_mv = pdo_pps_apdo_min_voltage(pdo);
+			max_src_mv = pdo_pps_apdo_max_voltage(pdo);
+			src_ma = pdo_pps_apdo_max_current(pdo);
+			src_mw = (src_ma * max_src_mv) / 1000;
+
+			/*
+			 * Now search through the sink PDOs to find a matching
+			 * PPS APDO. Again skip the first sink PDO as this will
+			 * always be 5V 3A.
+			 */
+			for (j = i; j < port->nr_snk_pdo; j++) {
+				pdo = port->snk_pdo[j];
+
+				switch (pdo_type(pdo)) {
+				case PDO_TYPE_APDO:
+					if (pdo_apdo_type(pdo) != APDO_TYPE_PPS) {
+						tcpm_log(port,
+							 "Not PPS APDO (sink), ignoring");
+						continue;
+					}
+
+					min_snk_mv =
+						pdo_pps_apdo_min_voltage(pdo);
+					max_snk_mv =
+						pdo_pps_apdo_max_voltage(pdo);
+					snk_ma =
+						pdo_pps_apdo_max_current(pdo);
+					break;
+				default:
+					tcpm_log(port,
+						 "Not APDO type (sink), ignoring");
+					continue;
+				}
+
+				if (max_src_mv <= max_snk_mv &&
+				    min_src_mv >= min_snk_mv) {
+					/* Prefer higher voltages if available */
+					if ((src_mw == max_mw &&
+					     min_src_mv > max_mv) ||
+					    src_mw > max_mw) {
+						src_pdo = i;
+						snk_pdo = j;
+						max_mw = src_mw;
+						max_mv = max_src_mv;
+					}
+				}
+			}
+
+			break;
+		default:
+			tcpm_log(port, "Not APDO type (source), ignoring");
+			continue;
+		}
+	}
+
+	if (src_pdo) {
+		pdo = port->source_caps[src_pdo];
+
+		port->pps_data.min_volt = pdo_pps_apdo_min_voltage(pdo);
+		port->pps_data.max_volt = pdo_pps_apdo_max_voltage(pdo);
+		port->pps_data.max_curr =
+			min_pps_apdo_current(pdo, port->snk_pdo[snk_pdo]);
+		port->pps_data.out_volt =
+			min(pdo_pps_apdo_max_voltage(pdo), port->pps_data.out_volt);
+		port->pps_data.op_curr =
+			min(port->pps_data.max_curr, port->pps_data.op_curr);
+	}
+
+	return src_pdo;
+}
+
 static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
 {
 	unsigned int mv, ma, mw, flags;
@@ -1849,10 +2091,18 @@ static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
 	matching_snk_pdo = port->snk_pdo[snk_pdo_index];
 	type = pdo_type(pdo);
 
-	if (type == PDO_TYPE_FIXED)
+	switch (type) {
+	case PDO_TYPE_FIXED:
 		mv = pdo_fixed_voltage(pdo);
-	else
+		break;
+	case PDO_TYPE_BATT:
+	case PDO_TYPE_VAR:
 		mv = pdo_min_voltage(pdo);
+		break;
+	default:
+		tcpm_log(port, "Invalid PDO selected!");
+		return -EINVAL;
+	}
 
 	/* Select maximum available current within the sink pdo's limit */
 	if (type == PDO_TYPE_BATT) {
@@ -1917,6 +2167,105 @@ static int tcpm_pd_send_request(struct tcpm_port *port)
 	msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
 				  port->pwr_role,
 				  port->data_role,
+				  port->negotiated_rev,
+				  port->message_id, 1);
+	msg.payload[0] = cpu_to_le32(rdo);
+
+	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
+}
+
+static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
+{
+	unsigned int out_mv, op_ma, op_mw, min_mv, max_mv, max_ma, flags;
+	enum pd_pdo_type type;
+	unsigned int src_pdo_index;
+	u32 pdo;
+
+	src_pdo_index = tcpm_pd_select_pps_apdo(port);
+	if (!src_pdo_index)
+		return -EOPNOTSUPP;
+
+	pdo = port->source_caps[src_pdo_index];
+	type = pdo_type(pdo);
+
+	switch (type) {
+	case PDO_TYPE_APDO:
+		if (pdo_apdo_type(pdo) != APDO_TYPE_PPS) {
+			tcpm_log(port, "Invalid APDO selected!");
+			return -EINVAL;
+		}
+		min_mv = port->pps_data.min_volt;
+		max_mv = port->pps_data.max_volt;
+		max_ma = port->pps_data.max_curr;
+		out_mv = port->pps_data.out_volt;
+		op_ma = port->pps_data.op_curr;
+		break;
+	default:
+		tcpm_log(port, "Invalid PDO selected!");
+		return -EINVAL;
+	}
+
+	flags = RDO_USB_COMM | RDO_NO_SUSPEND;
+
+	op_mw = (op_ma * out_mv) / 1000;
+	if (op_mw < port->operating_snk_mw) {
+		/*
+		 * Try raising current to meet power needs. If that's not enough
+		 * then try upping the voltage. If that's still not enough
+		 * then we've obviously chosen a PPS APDO which really isn't
+		 * suitable so abandon ship.
+		 */
+		op_ma = (port->operating_snk_mw * 1000) / out_mv;
+		if ((port->operating_snk_mw * 1000) % out_mv)
+			++op_ma;
+		op_ma += RDO_PROG_CURR_MA_STEP - (op_ma % RDO_PROG_CURR_MA_STEP);
+
+		if (op_ma > max_ma) {
+			op_ma = max_ma;
+			out_mv = (port->operating_snk_mw * 1000) / op_ma;
+			if ((port->operating_snk_mw * 1000) % op_ma)
+				++out_mv;
+			out_mv += RDO_PROG_VOLT_MV_STEP -
+				  (out_mv % RDO_PROG_VOLT_MV_STEP);
+
+			if (out_mv > max_mv) {
+				tcpm_log(port, "Invalid PPS APDO selected!");
+				return -EINVAL;
+			}
+		}
+	}
+
+	tcpm_log(port, "cc=%d cc1=%d cc2=%d vbus=%d vconn=%s polarity=%d",
+		 port->cc_req, port->cc1, port->cc2, port->vbus_source,
+		 port->vconn_role == TYPEC_SOURCE ? "source" : "sink",
+		 port->polarity);
+
+	*rdo = RDO_PROG(src_pdo_index + 1, out_mv, op_ma, flags);
+
+	tcpm_log(port, "Requesting APDO %d: %u mV, %u mA",
+		 src_pdo_index, out_mv, op_ma);
+
+	port->pps_data.op_curr = op_ma;
+	port->pps_data.out_volt = out_mv;
+
+	return 0;
+}
+
+static int tcpm_pd_send_pps_request(struct tcpm_port *port)
+{
+	struct pd_message msg;
+	int ret;
+	u32 rdo;
+
+	ret = tcpm_pd_build_pps_request(port, &rdo);
+	if (ret < 0)
+		return ret;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
+				  port->pwr_role,
+				  port->data_role,
+				  port->negotiated_rev,
 				  port->message_id, 1);
 	msg.payload[0] = cpu_to_le32(rdo);
 
@@ -2103,6 +2452,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_typec_disconnect(port);
 	port->attached = false;
 	port->pd_capable = false;
+	port->pps_data.supported = false;
 
 	/*
 	 * First Rx ID should be 0; set this to a sentinel of -1 so that
@@ -2120,6 +2470,8 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_set_attached_state(port, false);
 	port->try_src_count = 0;
 	port->try_snk_count = 0;
+	port->supply_voltage = 0;
+	port->current_limit = 0;
 }
 
 static void tcpm_detach(struct tcpm_port *port)
@@ -2364,6 +2716,7 @@ static void run_state_machine(struct tcpm_port *port)
 		typec_set_pwr_opmode(port->typec_port, opmode);
 		port->pwr_opmode = TYPEC_PWR_MODE_USB;
 		port->caps_count = 0;
+		port->negotiated_rev = PD_MAX_REV;
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		port->explicit_contract = false;
@@ -2424,6 +2777,7 @@ static void run_state_machine(struct tcpm_port *port)
 
 		tcpm_swap_complete(port, 0);
 		tcpm_typec_connect(port);
+
 		tcpm_check_send_discover(port);
 		/*
 		 * 6.3.5
@@ -2447,6 +2801,7 @@ static void run_state_machine(struct tcpm_port *port)
 	case SNK_UNATTACHED:
 		if (!port->non_pd_role_swap)
 			tcpm_swap_complete(port, -ENOTCONN);
+		tcpm_pps_complete(port, -ENOTCONN);
 		tcpm_snk_detach(port);
 		if (tcpm_start_drp_toggling(port)) {
 			tcpm_set_state(port, DRP_TOGGLING, 0);
@@ -2536,6 +2891,7 @@ static void run_state_machine(struct tcpm_port *port)
 					      port->cc2 : port->cc1);
 		typec_set_pwr_opmode(port->typec_port, opmode);
 		port->pwr_opmode = TYPEC_PWR_MODE_USB;
+		port->negotiated_rev = PD_MAX_REV;
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		port->explicit_contract = false;
@@ -2606,6 +2962,24 @@ static void run_state_machine(struct tcpm_port *port)
 					    PD_T_SENDER_RESPONSE);
 		}
 		break;
+	case SNK_NEGOTIATE_PPS_CAPABILITIES:
+		ret = tcpm_pd_send_pps_request(port);
+		if (ret < 0) {
+			port->pps_status = ret;
+			/*
+			 * If this was called due to updates to sink
+			 * capabilities, and pps is no longer valid, we should
+			 * safely fall back to a standard PDO.
+			 */
+			if (port->update_sink_caps)
+				tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
+			else
+				tcpm_set_state(port, SNK_READY, 0);
+		} else {
+			tcpm_set_state_cond(port, hard_reset_state(port),
+					    PD_T_SENDER_RESPONSE);
+		}
+		break;
 	case SNK_TRANSITION_SINK:
 	case SNK_TRANSITION_SINK_VBUS:
 		tcpm_set_state(port, hard_reset_state(port),
@@ -2613,6 +2987,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SNK_READY:
 		port->try_snk_count = 0;
+		port->update_sink_caps = false;
 		if (port->explicit_contract) {
 			typec_set_pwr_opmode(port->typec_port,
 					     TYPEC_PWR_MODE_PD);
@@ -2622,6 +2997,8 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_swap_complete(port, 0);
 		tcpm_typec_connect(port);
 		tcpm_check_send_discover(port);
+		tcpm_pps_complete(port, port->pps_status);
+
 		break;
 
 	/* Accessory states */
@@ -2668,6 +3045,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
 		break;
 	case SNK_HARD_RESET_SINK_OFF:
+		memset(&port->pps_data, 0, sizeof(port->pps_data));
 		tcpm_set_vconn(port, false);
 		tcpm_set_charge(port, false);
 		tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
@@ -2888,6 +3266,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case ERROR_RECOVERY:
 		tcpm_swap_complete(port, -EPROTO);
+		tcpm_pps_complete(port, -EPROTO);
 		tcpm_set_state(port, PORT_RESET, 0);
 		break;
 	case PORT_RESET:
@@ -3470,6 +3849,162 @@ static int tcpm_try_role(const struct typec_capability *cap, int role)
 	return ret;
 }
 
+static int __maybe_unused tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
+{
+	unsigned int target_mw;
+	int ret;
+
+	mutex_lock(&port->swap_lock);
+	mutex_lock(&port->lock);
+
+	if (!port->pps_data.active) {
+		ret = -EOPNOTSUPP;
+		goto port_unlock;
+	}
+
+	if (port->state != SNK_READY) {
+		ret = -EAGAIN;
+		goto port_unlock;
+	}
+
+	if (op_curr > port->pps_data.max_curr) {
+		ret = -EINVAL;
+		goto port_unlock;
+	}
+
+	target_mw = (op_curr * port->pps_data.out_volt) / 1000;
+	if (target_mw < port->operating_snk_mw) {
+		ret = -EINVAL;
+		goto port_unlock;
+	}
+
+	reinit_completion(&port->pps_complete);
+	port->pps_data.op_curr = op_curr;
+	port->pps_status = 0;
+	port->pps_pending = true;
+	tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
+	mutex_unlock(&port->lock);
+
+	if (!wait_for_completion_timeout(&port->pps_complete,
+				msecs_to_jiffies(PD_PPS_CTRL_TIMEOUT)))
+		ret = -ETIMEDOUT;
+	else
+		ret = port->pps_status;
+
+	goto swap_unlock;
+
+port_unlock:
+	mutex_unlock(&port->lock);
+swap_unlock:
+	mutex_unlock(&port->swap_lock);
+
+	return ret;
+}
+
+static int __maybe_unused tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
+{
+	unsigned int target_mw;
+	int ret;
+
+	mutex_lock(&port->swap_lock);
+	mutex_lock(&port->lock);
+
+	if (!port->pps_data.active) {
+		ret = -EOPNOTSUPP;
+		goto port_unlock;
+	}
+
+	if (port->state != SNK_READY) {
+		ret = -EAGAIN;
+		goto port_unlock;
+	}
+
+	if (out_volt < port->pps_data.min_volt ||
+	    out_volt > port->pps_data.max_volt) {
+		ret = -EINVAL;
+		goto port_unlock;
+	}
+
+	target_mw = (port->pps_data.op_curr * out_volt) / 1000;
+	if (target_mw < port->operating_snk_mw) {
+		ret = -EINVAL;
+		goto port_unlock;
+	}
+
+	reinit_completion(&port->pps_complete);
+	port->pps_data.out_volt = out_volt;
+	port->pps_status = 0;
+	port->pps_pending = true;
+	tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
+	mutex_unlock(&port->lock);
+
+	if (!wait_for_completion_timeout(&port->pps_complete,
+				msecs_to_jiffies(PD_PPS_CTRL_TIMEOUT)))
+		ret = -ETIMEDOUT;
+	else
+		ret = port->pps_status;
+
+	goto swap_unlock;
+
+port_unlock:
+	mutex_unlock(&port->lock);
+swap_unlock:
+	mutex_unlock(&port->swap_lock);
+
+	return ret;
+}
+
+static int __maybe_unused tcpm_pps_activate(struct tcpm_port *port, bool activate)
+{
+	int ret = 0;
+
+	mutex_lock(&port->swap_lock);
+	mutex_lock(&port->lock);
+
+	if (!port->pps_data.supported) {
+		ret = -EOPNOTSUPP;
+		goto port_unlock;
+	}
+
+	/* Trying to deactivate PPS when already deactivated so just bail */
+	if (!port->pps_data.active && !activate)
+		goto port_unlock;
+
+	if (port->state != SNK_READY) {
+		ret = -EAGAIN;
+		goto port_unlock;
+	}
+
+	reinit_completion(&port->pps_complete);
+	port->pps_status = 0;
+	port->pps_pending = true;
+
+	/* Trigger PPS request or move back to standard PDO contract */
+	if (activate) {
+		port->pps_data.out_volt = port->supply_voltage;
+		port->pps_data.op_curr = port->current_limit;
+		tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
+	} else {
+		tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
+	}
+	mutex_unlock(&port->lock);
+
+	if (!wait_for_completion_timeout(&port->pps_complete,
+				msecs_to_jiffies(PD_PPS_CTRL_TIMEOUT)))
+		ret = -ETIMEDOUT;
+	else
+		ret = port->pps_status;
+
+	goto swap_unlock;
+
+port_unlock:
+	mutex_unlock(&port->lock);
+swap_unlock:
+	mutex_unlock(&port->swap_lock);
+
+	return ret;
+}
+
 static void tcpm_init(struct tcpm_port *port)
 {
 	enum typec_cc_status cc1, cc2;
@@ -3603,13 +4138,18 @@ int tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
 	mutex_lock(&port->lock);
 	port->nr_snk_pdo = tcpm_copy_pdos(port->snk_pdo, pdo, nr_pdo);
 	port->operating_snk_mw = operating_snk_mw;
+	port->update_sink_caps = true;
 
 	switch (port->state) {
 	case SNK_NEGOTIATE_CAPABILITIES:
+	case SNK_NEGOTIATE_PPS_CAPABILITIES:
 	case SNK_READY:
 	case SNK_TRANSITION_SINK:
 	case SNK_TRANSITION_SINK_VBUS:
-		tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
+		if (port->pps_data.active)
+			tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
+		else
+			tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
 		break;
 	default:
 		break;
@@ -3651,6 +4191,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 
 	init_completion(&port->tx_complete);
 	init_completion(&port->swap_complete);
+	init_completion(&port->pps_complete);
 	tcpm_debugfs_init(port);
 
 	if (tcpm_validate_caps(port, tcpc->config->src_pdo,
@@ -3677,7 +4218,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->typec_caps.type = tcpc->config->type;
 	port->typec_caps.data = tcpc->config->data;
 	port->typec_caps.revision = 0x0120;	/* Type-C spec release 1.2 */
-	port->typec_caps.pd_revision = 0x0200;	/* USB-PD spec release 2.0 */
+	port->typec_caps.pd_revision = 0x0300;	/* USB-PD spec release 3.0 */
 	port->typec_caps.dr_set = tcpm_dr_set;
 	port->typec_caps.pr_set = tcpm_pr_set;
 	port->typec_caps.vconn_set = tcpm_vconn_set;
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index ff359bdf..09b570f 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -103,8 +103,8 @@ enum pd_ext_msg_type {
 	 (((cnt) & PD_HEADER_CNT_MASK) << PD_HEADER_CNT_SHIFT) |	\
 	 ((ext_hdr) ? PD_HEADER_EXT_HDR : 0))
 
-#define PD_HEADER_LE(type, pwr, data, id, cnt) \
-	cpu_to_le16(PD_HEADER((type), (pwr), (data), PD_REV20, (id), (cnt), (0)))
+#define PD_HEADER_LE(type, pwr, data, rev, id, cnt) \
+	cpu_to_le16(PD_HEADER((type), (pwr), (data), (rev), (id), (cnt), (0)))
 
 static inline unsigned int pd_header_cnt(u16 header)
 {
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index f5bda9a..b231b93 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -36,6 +36,7 @@ enum typec_cc_polarity {
 /* Time to wait for TCPC to complete transmit */
 #define PD_T_TCPC_TX_TIMEOUT	100		/* in ms	*/
 #define PD_ROLE_SWAP_TIMEOUT	(MSEC_PER_SEC * 10)
+#define PD_PPS_CTRL_TIMEOUT	(MSEC_PER_SEC * 10)
 
 enum tcpm_transmit_status {
 	TCPC_TX_SUCCESS = 0,
-- 
1.9.1
